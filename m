From: Carlos Corbacho <cathectic@slackadelic.com>
Subject: Re: Enabling "extra" scancodes on some Acer laptops
Date: Tue, 16 Oct 2007 16:12:40 +0100
Message-ID: <200710161612.40914.cathectic@slackadelic.com>
References: <200710141803.09039.cathectic@slackadelic.com> <d120d5000710160737p188215fei5c4c56ef5734ae2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000710160737p188215fei5c4c56ef5734ae2d@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Dimitry,

On Tuesday 16 October 2007 15:37:37 you wrote:
> I think it could be added to i8042 driver to enable it. How messy is
> detection?

I use simple DMI matching in acer_acpi to do this on known broken laptops. 

(acerhk calls directly into the BIOS to find this information - but I suspect 
the data from that could easily be extracted and converted to proper DMI 
table entries).

These are the the three that I know of (and are supported by acer_acpi) that 
require this quirk:

static struct dmi_system_id dritek_extension_quirk[] = {
        {
                .callback = dmi_matched,
                .ident = "Acer Aspire 5650",
                .matches = {
                        DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
                        DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5650"),
                },
        },
	{
		.callback = dmi_matched,
		.ident = "Acer Aspire 5680",
		.matches = {
			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5680"),
		},
	},
	{
		.callback = dmi_matched,
		.ident = "Acer TravelMate 2490",
		.matches = {
			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 2490"),
		},
	},
	{}
};

-Carlos
-- 
E-Mail: cathectic@gmail.com
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
