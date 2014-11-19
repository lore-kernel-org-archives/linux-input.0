From: ulrik.debie-os@e2big.org
Subject: Re: [git pull] Input updates for 3.18-rc4
Date: Wed, 19 Nov 2014 22:54:17 +0100
Message-ID: <20141119215417.GC5464@lantern>
References: <20141114222640.GA39748@dtor-ws>
 <CAN+gG=FaovQETa3+qQsLoBBQnbZ8Q2uoQJD6_XvAmCCvGTHT1g@mail.gmail.com>
 <CAJBHPojp7JVG6KKgrNfbC-V5ibPs-j6+BnqrSDkxvak0vNGM8w@mail.gmail.com>
 <20141119181247.GE37989@dtor-ws>
 <CAJBHPohu71BXqyZ4u74tAiP84UcQhXgto34k8NtNHPgw61WvLQ@mail.gmail.com>
 <20141119183921.GF37989@dtor-ws>
 <CAJBHPog3qRMQgNnso_csUOgR30A6eFPx4PkTzfCzkB3Gd5oVfQ@mail.gmail.com>
 <20141119210552.GA5464@lantern>
 <CAJBHPoiQ0ZuW2TjDu68SQrgOS=+OMTt0hptBmVedMLS55td1Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJBHPoiQ0ZuW2TjDu68SQrgOS=+OMTt0hptBmVedMLS55td1Rg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Overhagen <marcus.overhagen@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Wed, Nov 19, 2014 at 10:49:05PM +0100, Marcus Overhagen wrote:
> On Wed, Nov 19, 2014 at 10:05 PM,  <ulrik.debie-os@e2big.org> wrote:
> 
> > Marcus, do you even have a trackpoint ?
> This is a clickpad without buttons and without trackpoint.
> Looks similar to this image: http://i.imgur.com/5pcCxqa.jpg
> 
> > Marcus, can you send the firmware and capabilities information for your laptop
> > (it is available in the kernel messages). Could you send me a kernel message log for a period of 1 minute when using the touchpad with the debug set to 2 ?
> I sent you an email. hope that helps.
> 

I received it, thanks. It contains both packet[3]==0x42 and packet[3]==0x46, 
but the touchpad part of the driver does not do anything different for the
bit 0x04. I'll anaylze the dump and look for patterns in the coming days.

Thanks again,
Ulrik
