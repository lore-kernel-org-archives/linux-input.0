From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Regression since commit 92bac83
Date: Mon, 19 Oct 2015 10:08:35 +0200
Message-ID: <5624A503.7090609@redhat.com>
References: <5624327B.7080906@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5624327B.7080906@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 19-10-15 01:59, Larry Finger wrote:
> Hi,
>
> I recently upgraded the kernel in a Dell Latitude D600 and found that the touchpad clicks failed. The problem was bisected to commit 92bac83dd79e60e65c475222e41a992a70434beb ("Input: alps - non interleaved V2 dualpoint has separate stick button bits"). The laptop has a combination touchpad and control stick. For this device, the following values are found:
>
> priv->protoversion is 0x200 (ALPS_PROTO_V2)
> priv->flags is 0x6 (ALPS_DUALPOINT | ALPS_PASS)
>
> As a result, the new code added in this patch is executed, and left, right, and middle are updated. Once this code is introduced, a left click causes some event as it will wake a sleeping screen, but not select any windows or do anything useful.
>
> Please advise on what information would be needed to help debug this problem.

Can you build a recent upstream kernel from source, and when building it
comment out these lines in drivers/input/mouse/alps.c, around lines 2555 - 2556

         if (dmi_name_in_vendors("Dell"))
                 priv->flags |= ALPS_DELL;

That should fix things, if that fixes things we need to rename the flag
and move to a list of dmi-matched models (rather then vendor) where the new behavior
introduced by the patch causing you problems is actually necessary.

Step 1 is confirming that not setting the flag fixes things for you,
if you can get back to us confirming that, then I'll whip up a patch
to switch to model matching (which is not ideal, but seems to be
necessary).

Regards,

Hans
