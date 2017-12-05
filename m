From: Tomasz Kramkowski <tk@the-tk.com>
Subject: Re: [PATCH] HID: elecom: rewrite report fixup for EX-G and future
 mice
Date: Tue, 5 Dec 2017 20:17:52 +0000
Message-ID: <20171205201307.GA13831@gaia.local>
References: <20171204205550.2621-1-tk@the-tk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171204205550.2621-1-tk@the-tk.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Yuxuan Shui <yshuiv7@gmail.com>, Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.eu>, Alex Manoussakis <amanou@gnu.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Dec 04, 2017 at 08:55:50PM +0000, Tomasz Kramkowski wrote:
> +static void mouse_button_fixup(struct hid_device *hdev,
> +			       __u8 *rdesc, unsigned int *rsize,
> +			       int nbuttons)

I've just remembered what has been bugging me yesterday when I was
reviewing this patch. I had come to the realisation (and then
subsequently forgotten) that this function should probably return __u8 *
and also get assigned to rdesc on the other end. It seems to me that it
makes most sense to allow for the possibility (although slim) of this
function eventually being expanded to actually replace the report
descriptor (technically the full report descriptor contains a bunch of
useless crap like INPUT reports for media keys and the FEATURE report
which as far as I can tell is totally useless or may or may not be some
tactic by ELECOM to future-proof their firmware).

The other option would be to make rsize not a pointer because it doesn't
need to be. But that kind of makes the flow of the two functions
somewhat inconsistent. I'm not sure if I'm alone in that feeling.

Anyway, I should have written this down when I first caught it, sorry
for the noise. I'll let you guys review this patch and give any other
feedback you might have and I'll try to get a v2 as soon as possible
afterwards.

-- 
Tomasz Kramkowski | GPG: 40B037BA0A5B8680 | Web: https://the-tk.com/
