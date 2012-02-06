From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch v3 0/3] Support of Perixx Peripad 701 for
 hid-multitouch
Date: Mon, 6 Feb 2012 13:24:01 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202061323430.24127@pobox.suse.cz>
References: <1328371730-10944-1-git-send-email-benjamin.tissoires@gmail.com> <20120206083909.GA3972@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120206083909.GA3972@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 6 Feb 2012, Henrik Rydberg wrote:

> > This is the v3 of the support of Perixx Peripad 701.
> > 
> > I included the changes asked by Henrik & Dmitry:
> > -           code = ((usage->hid - 1) & HID_USAGE) + BTN_MOUSE;
> > +           code =  BTN_MOUSE + ((usage->hid - 1) & HID_USAGE);
> > use of min;
> > remove remove the call to input_mt_report_finger_count;
> > remove debug information;
> > some cosmetic changes (parenthesis, typos)
> 
> Looking good now, thanks.
> 
>     Acked-by: Henrik Rydberg <rydberg@euromail.se>

I have now applied the patchset. Thanks everybody.

-- 
Jiri Kosina
SUSE Labs
