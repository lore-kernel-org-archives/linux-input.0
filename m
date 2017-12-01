From: Jonathan Liu <net147@gmail.com>
Subject: Re: Support TrackStick of Thinkpad L570
Date: Sat, 2 Dec 2017 00:26:40 +1100
Message-ID: <CANwerB1NVueMgpaO1eFLMsfmaSmTmNaQmcufjY5sr_gNhy1RYQ@mail.gmail.com>
References: <20171129083358.5063-1-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171129083358.5063-1-masaki.ota@jp.alps.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, benjamin.tissoires@redhat.com, pali.rohar@gmail.com, aaron.ma@canonical.com, jaak@ristioja.ee, Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Masaki,

On 29 November 2017 at 19:33, Masaki Ota <012nexus@gmail.com> wrote:
> From: Masaki Ota <masaki.ota@jp.alps.com>
> - The issue is that Thinkpad L570 TrackStick does not work. Because the main interface of Thinkpad L570 device is SMBus, so ALPS overlooked PS2 interface Firmware setting of TrackStick. The detail is that TrackStick otp bit is disabled.
> - Add the code that checks 0xD7 address value. This value is device number information, so we can identify the device by checking this value.
> - If we check 0xD7 value, we need to enable Command mode and after check the value we need to disable Command mode, then we have to enable the device(0xF4 command).
> - Thinkpad L570 device number is 0x0C or 0x1D. If it is TRUE, enable ALPS_DUALPOINT flag.
>
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> ---
>  drivers/input/mouse/alps.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)

Tested-by: Jonathan Liu <net147@gmail.com>

This fixes trackstick and physical left/middle/right mouse buttons
above touchpad on Lenovo ThinkPad E570p laptop for me.

Regards,
Jonathan
