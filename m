From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: steam: use hid_device.driver_data instead of
 hid_set_drvdata()
Date: Fri, 8 Jun 2018 15:45:39 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1806081545070.6203@cbobk.fhfr.pm>
References: <20180522201006.14003-1-rodrigorivascosta@gmail.com> <20180601182750.GA23501@casa>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601182750.GA23501@casa>
Sender: linux-kernel-owner@vger.kernel.org
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, =?ISO-8859-15?Q?Cl=E9ment_VUCHENER?= <clement.vuchener@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, 1 Jun 2018, Rodrigo Rivas Costa wrote:

> Could you check my previous patch to see if it makes any sense?
> My machine currently crashes without it, but I'm not sure why. If you
> think it is worth it I can try and bisect it.

I sent a pull request to Linus earlier today, I'll stage this for 2nd wave 
so that it still goes in for 4.18.

-- 
Jiri Kosina
SUSE Labs
