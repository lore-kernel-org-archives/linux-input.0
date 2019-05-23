From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH 2/2] Input: synaptics - remove X240 from the topbuttonpad
 list
Date: Thu, 23 May 2019 13:02:09 +0800
Message-ID: <cdcc48a7-bd52-5ea4-6712-7f77604fe549@canonical.com>
References: <20190519072711.2592-1-aaron.ma@canonical.com>
 <20190519072711.2592-2-aaron.ma@canonical.com>
 <20190521050850.GC183429@dtor-ws>
 <CAO-hwJLXB8Qec9Yhz0y6WgvEpE6KHk_53g4VtPGj9mfvMzk4dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJLXB8Qec9Yhz0y6WgvEpE6KHk_53g4VtPGj9mfvMzk4dg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Christopher Heiny <Cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-input@vger.kernel.org



On 5/21/19 2:49 PM, Benjamin Tissoires wrote:
> A quick google image search showed that the X240 had 2 versions: one
> with the top software buttons, one without.
> 
> And this definitively rings a bell. I am sure we asked Lenovo and
> Synaptics to change the PnPID when they would do such a change, but
> they "forgot" during the *40 series refresh.
> We have code in place to fix the reported ranges of the coordinates,
> and we had to check against the board id (see min_max_pnpid_table[] in
> synaptics.c).
> Unfortunately, X240 (LEN0035) is not part of this table, so I don't
> know which refresh of the board ID has implemented the non top
> software buttons.

After double confirm from Lenovo, looks like they mixed up with
touchpads on X240/X240s.

For now only one user reported this LEN0035 doesn't work on SMBus mode.
module parameter can be a workaround.
Maybe some touchpads with software top buttons are working well on
SMBus. Let's keep eyes on this issue for now.

Regards,
Aaron

> 
> Cheers,
> Benjamin
