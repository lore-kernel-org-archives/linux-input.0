From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] Elantech Touchpad: Fix Elantech touchpad and trackpoint
 for Lenovo ThinkPad notebooks.
Date: Sun, 6 Jan 2019 17:44:35 +0800
Message-ID: <F09EA46C-73C3-48A8-9105-F4DE55D7FBB6@canonical.com>
References: <20181228175327.14863-1-kaelinphilipp@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181228175327.14863-1-kaelinphilipp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Philipp Kaelin <kaelinphilipp@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

> On Dec 29, 2018, at 1:53 AM, Philipp Kaelin <kaelinphilipp@gmail.com> wrote:
> 
> Initial situation:
> - The touchpad of a Lenovo ThinkPad L580 doesn't work with newer kernel versions eg. 4.20
> - It used to work on earlier versions eg. 4.14
> 
> Cause:
> - The elantech driver was adapted in to support SMBus wich not all firmware versions
>  of the elantech firmware support. The SMBus is used as default.
> 
> Solution:
> - Previously a blacklist was introduced for devices which doesn't support the access using SMBus.
>  The ThinkPad P52 and P72 have already been fixed by adding it to such a blacklist in a prevois patch.
>  The exact same solution fixed also the issue on the mentioned ThinkPad L580.
> 
> Change:
> 1) The firmware id of the ThinkPad L580 was added to this blacklist.
> 2) To not have a half baked solution the information which firmware versions are using the same driver
>   and therefore most probably have all the same issue was extracted from the Lenovo Windows driver package.
>   All these firmware versions are now also added to the blacklist.

I actually have a reversed situation: 
I’d like to make Elantech touchpad defaults to SMBus on some platforms, but the firmware version does not match to ETP_NEW_IC_SMBUS_HOST_NOTIFY().

Use whitelist is obviously a bad idea so I’d like to know do you have any better approach in mind?

Kai-Heng

> 
> Risk assesment:
> As in prevois versions of the kernel eg. 4.14 none of the devices used to be accessed via SMBus
> (and they are reported to work at this time) it's quite safe that this blaklisting doesn't cause
> any harm on devices which have not been testes but included in the blacklist.
> 
> Signed-off-by: Philipp Kaelin <kaelinphilipp@gmail.com>
> ---
> drivers/input/mouse/elantech.c | 23 +++++++++++++++++++----
> 1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 9fe075c137dc..e5fa8cfd8393 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1772,10 +1772,25 @@ static const char * const i2c_blacklist_pnp_ids[] = {
> 	 * These are known to not be working properly as bits are missing
> 	 * in elan_i2c.
> 	 */
> -	"LEN2131", /* ThinkPad P52 w/ NFC */
> -	"LEN2132", /* ThinkPad P52 */
> -	"LEN2133", /* ThinkPad P72 w/ NFC */
> -	"LEN2134", /* ThinkPad P72 */
> +	"LEN2131", /* Walter-3	w/ NFC		ThinkPad P52 w/ NFC	*/
> +	"LEN2132", /* Walter-3	w/o/ NFC	ThinkPad P52		*/
> +	"LEN2133", /* Chiron	w/ NFC		ThinkPad P72 w/ NFC	*/
> +	"LEN2134", /* Chiron	w/o/ NFC	ThinkPad P72		*/
> +	"LEN2037", /* Lando	w/ NFC		ThinkPad L580 w/ NFC	*/
> +	"LEN2038", /* Lando	w/o/ NFC	ThinkPad L580		*/
> +	"LEN004F", /* Storm	w/o/ NFC				*/
> +	"LEN005C", /* Storm	w/ NFC					*/
> +	"LEN2030", /* Carling						*/
> +	"LEN2031", /* Bell						*/
> +	"LEN2032", /* Bell-2						*/
> +	"LEN2033", /* Storm-2						*/
> +	"LEN2034", /* Storm-3						*/
> +	"LEN2035", /* Solo	w/ NFC					*/
> +	"LEN2036", /* Solo	w/o/ NFC				*/
> +	"LEN2039", /* Leia						*/
> +	"LEN2130", /* Kylo	(Clamshell)				*/
> +	"LEN008F", /* Kolar	w/o/ NF					*/
> +	"LEN0090", /* Kolar	w/ NFC					*/
> 	NULL
> };
> 
> -- 
> 2.19.2
> 
