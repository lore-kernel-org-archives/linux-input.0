From: Henk <henk.vergonet@gmail.com>
Subject: Fwd: [RFC PATCH 2/2] USB: input: yealink.c: add mapping for "RING"
 and "MUTE" keys
Date: Fri, 9 Jan 2015 13:42:09 +0100
Message-ID: <CAMFK4TOjQaCWbhyNbe7MrDg+12WY0TMTh_=s3QsziJVu=XgH6A@mail.gmail.com>
References: <1419259269-23820-1-git-send-email-dforsi@gmail.com>
	<1419259269-23820-3-git-send-email-dforsi@gmail.com>
	<CAMFK4TM4zVNWBt14vS3T=eQMtwM2OMLW4Wf5dfHS1vKVoPrQiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMFK4TM4zVNWBt14vS3T=eQMtwM2OMLW4Wf5dfHS1vKVoPrQiw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Henk Vergonet <henk.vergonet@gmail.com>


On Mon, Dec 22, 2014 at 3:41 PM, Daniele Forsi <dforsi@gmail.com> wrote:
>
> According to the user manual of the "VOIP-3 SKY" USB phone, the RING
> key is used to select different ring tones and the MUTE key is used
> to mute the microphone.
>
> Signed-off-by: Daniele Forsi <dforsi@gmail.com>
> ---
>  drivers/input/misc/yealink.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
> index e9403da..0b86c49 100644
> --- a/drivers/input/misc/yealink.c
> +++ b/drivers/input/misc/yealink.c
> @@ -189,7 +189,9 @@ static int setChar(struct yealink_dev *yld, int el, int chr)
>   * USB-P1K button layout:
>   *
>   *             up
> + *            ring
>   *       IN           OUT
> + *            mute
>   *            down
>   *
>   *     pickup   C    hangup
> @@ -207,7 +209,9 @@ static int map_p1k_to_key(int scancode)
>         switch(scancode) {              /* phone key:   */
>         case 0x23: return KEY_LEFT;     /*   IN         */
>         case 0x33: return KEY_UP;       /*   up         */
> +       case 0x44: return KEY_SOUND;    /*   ring       */
>         case 0x04: return KEY_RIGHT;    /*   OUT        */
> +       case 0x41: return KEY_MICMUTE;  /*   mute       */
>         case 0x24: return KEY_DOWN;     /*   down       */
>         case 0x03: return KEY_ENTER;    /*   pickup     */
>         case 0x14: return KEY_BACKSPACE; /*  C          */
> --
> 2.1.3
>
