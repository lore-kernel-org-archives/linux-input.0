From: Marcus Overhagen <marcus.overhagen@gmail.com>
Subject: Re: [git pull] Input updates for 3.18-rc4
Date: Wed, 19 Nov 2014 23:21:31 +0100
Message-ID: <CAJBHPojucTj27EVLQRjDHZJe6bwZW3i-brwQ9N8mVY3rTp8koA@mail.gmail.com>
References: <20141114222640.GA39748@dtor-ws>
	<CAN+gG=FaovQETa3+qQsLoBBQnbZ8Q2uoQJD6_XvAmCCvGTHT1g@mail.gmail.com>
	<CAJBHPojp7JVG6KKgrNfbC-V5ibPs-j6+BnqrSDkxvak0vNGM8w@mail.gmail.com>
	<20141119181247.GE37989@dtor-ws>
	<CAJBHPohu71BXqyZ4u74tAiP84UcQhXgto34k8NtNHPgw61WvLQ@mail.gmail.com>
	<20141119183921.GF37989@dtor-ws>
	<CAJBHPog3qRMQgNnso_csUOgR30A6eFPx4PkTzfCzkB3Gd5oVfQ@mail.gmail.com>
	<20141119210552.GA5464@lantern>
	<CAJBHPoiQ0ZuW2TjDu68SQrgOS=+OMTt0hptBmVedMLS55td1Rg@mail.gmail.com>
	<20141119215417.GC5464@lantern>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141119215417.GC5464@lantern>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Hi,

when moving a single finger [3] seems to be one of 0x21, 0x25, 0x31, 0x35
moving two fingers [3] seems to be mostly 0x22, 0x26, 0x32, 0x36  but
also sometimes it's 0x42, 0x46, 0x52, 0x56.
It seems to occationally seems to switch between these two groups
after touching the pad with three or more fingers, but not every time.

Moving three fingers I see[3] beeing  0x26, 0x36, 0x76, 0x66 (probably more)

regards
Marcus
