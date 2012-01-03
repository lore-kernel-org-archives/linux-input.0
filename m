From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v4] Input: keyboard - add device tree bindings for
 simple key matrixes
Date: Tue, 3 Jan 2012 14:37:44 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F11FF@HQMAIL01.nvidia.com>
References: <1325484557-27695-1-git-send-email-olof@lixom.net>
 <1325626648-9425-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1325626648-9425-1-git-send-email-olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Olof Johansson wrote at Tuesday, January 03, 2012 2:37 PM:
> This adds a simple device tree binding for simple key matrix data and
> a helper to fill in the platform data.
> 
> The implementation is in a shared file outside if drivers/input/keyboard
> since some drivers in drivers/input/misc might be making use of it
> as well.
> 
> Changes since v3:
>  * Dropped compatible field in matrix-keymap.txt
>  * Dropped linux,fn-key
>  * Dropped linux,fn-keymap optional property but included guideline on
>    naming convention
>  * Now passing property name in to the helper function (or will assume
>    "linux,keymap" if passed NULL)

> diff --git a/drivers/input/of_keymap.c b/drivers/input/of_keymap.c

> +struct matrix_keymap_data *
> +matrix_keyboard_of_fill_keymap(struct device_node *np, char *propname)
> +{
...
> +	kd = kmalloc(sizeof(*kd), GFP_KERNEL);
> +	if (!kd)
> +		return NULL;

Should that use kzalloc in case struct matrix_keymap_data grows some
new fields that people will assume are set to zero since the struct
would usually be in .data? Still, people should probably grep the code
when making such changes...

Otherwise,

Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

-- 
nvpublic
