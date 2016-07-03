describe RuboCop::Cop::Cask::HomepageMatchesUrl do
  include CopSharedExamples

  subject(:cop) { described_class.new }
  let(:missing_line_msg) do
    'stanza groups should be separated by a single empty line'
  end
  let(:extra_line_msg) do
    'stanzas within the same group should have no lines between them'
  end

  context 'when the url matches the homepage' do
    context 'and there is no comment' do
      let(:source) do
        <<-CASK.undent
          cask 'foo' do
            url 'https://foo.example.com/foo.zip'
            homepage 'https://foo.example.com'
          end
        CASK
      end

      include_examples 'does not report any offenses'
    end

    context 'but there is a comment' do
      let(:source) do
        <<-CASK.undent
          cask 'foo' do
            # foo.example.com was verified as official when first introduced to the cask
            url 'https://foo.example.com/foo.zip'
            homepage 'https://foo.example.com'
          end
        CASK
      end
      let(:expected_offenses) do
        [{
          message: '`foo.example.com` matches `foo.example.com`, ' \
                   'the comment above the `url` stanza is unnecessary',
          severity: :convention,
          line: 2,
          column: 2,
          source: '# foo.example.com was verified as official when ' \
                  'first introduced to the cask'
        }]
      end

      include_examples 'reports offenses'
    end
  end

  context 'when the url does not match the homepage' do
    context 'and there is a comment' do
      context 'which matches the url' do
        let(:source) do
          <<-CASK.undent
            cask 'foo' do
              # example.com was verified as official when first introduced to the cask
              url 'https://example.com/foo.zip'
              homepage 'https://foo.example.com'
            end
          CASK
        end

        include_examples 'does not report any offenses'
      end

      context 'which does not match the url' do
        let(:source) do
          <<-CASK.undent
            cask 'foo' do
              # example.org was verified as official when first introduced to the cask
              url 'https://example.com/foo.zip'
              homepage 'https://foo.example.com'
            end
          CASK
        end
        let(:expected_offenses) do
          [{
            message: '`example.org` does not match `example.com`',
            severity: :convention,
            line: 2,
            column: 2,
            source: '# example.org was verified as official when ' \
                    'first introduced to the cask'
          }]
        end

        include_examples 'reports offenses'
      end
    end

    context 'but the comment is missing' do
      let(:source) do
        <<-CASK.undent
          cask 'foo' do
            url 'https://example.com/foo.zip'
            homepage 'https://foo.example.com'
          end
        CASK
      end
      let(:expected_offenses) do
        [{
          message: '`example.com` does not match `foo.example.com`, a ' \
                   'comment in the form of `# example.com was verified as ' \
                   'official when first introduced to the cask` has to be ' \
                   'added above the `url` stanza',
          severity: :convention,
          line: 2,
          column: 2,
          source: "url 'https://example.com/foo.zip'"
        }]
      end

      include_examples 'reports offenses'
    end
  end
end
