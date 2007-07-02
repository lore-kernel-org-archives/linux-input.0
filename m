From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] USB: driver for CM109 chipset
Date: Mon, 2 Jul 2007 17:37:07 +0200
Message-ID: <20070702153707.GA27958@suse.cz>
References: <467FC7E5.7050901@db.org> <d120d5000706250729s3f0e8325n8e4eb9f5982d858c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000706250729s3f0e8325n8e4eb9f5982d858c@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Alfred E. Heggestad" <aeh@db.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Mon, Jun 25, 2007 at 10:29:13AM -0400, Dmitry Torokhov wrote:
> Hi Alfred,
> 
> On 6/25/07, Alfred E. Heggestad <aeh@db.org> wrote:
> >From: Alfred E. Heggestad <aeh@db.org>
> >
> >This driver adds support for USB VoIP phones using the CM109 chipset,
> >such as the KIP-1000. Keypad is scanned and events are reported to
> >the input subsystem. The buzzer can be activated by sending SND_TONE
> >or SND_BELL to the input device.
> >The driver has been tested with linux 2.6.21.3 on i386 and AMD64,
> >and linux 2.6.21.1 on Broadcom BCM3302 (MIPS, OpenWRT Project)
> >The current patch applies cleanly and is tested on linux 2.6.22-rc4
> >More testing and code review is welcome..
> >
> 
> Thank you for your patch. I have couple of comments:
> 
> - "input_dev->cdev.dev = &intf->dev;" should be "input_dev->dev.parent
> = &intf->dev;"
> - do not access input->private directly; use input_set_drvdata() and
> input_get_drvdata() helpers.
> - error handling for input_register_device();
> - I guess we need KEY_POUNDSIGN because I don't like that business
> with key_shift + key_3 (I did not like it in yealink either...)

Probably a KEY_KPPOUND. We should be sending the keypad keys on phones.

> Also could you please send your patches inline instead of an
> attachment - it makes much easire to comment that way.

-- 
Vojtech Pavlik
Director SuSE Labs
