From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v4 3/6] Input: synaptics - Query min dimensions for fw
 v8.1
Date: Fri, 06 Feb 2015 13:14:40 -0500
Message-ID: <54D50490.7090303@gmail.com>
References: <1423237499-2930-1-git-send-email-benjamin.tissoires@redhat.com> <1423237499-2930-4-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:57974 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002AbbBFSOm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2015 13:14:42 -0500
In-Reply-To: <1423237499-2930-4-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Martin <consume.noise@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org



On 02/06/2015 10:44 AM, Benjamin Tissoires wrote:
> From: Daniel Martin <consume.noise@gmail.com>
>
> Query the min dimensions even if the check
>      SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7
> fails, but we know that the firmware version 8.1 is safe.
>
> With that we don't need quirks for post-2013 models anymore as they
> expose correct min and max dimensions.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91541
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Martin <consume.noise@gmail.com>
>    re-order the tests to check SYN_CAP_MIN_DIMENSIONS even on FW 8.1
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> v2: Don't use a list for safe firmwares.
>
>   drivers/input/mouse/synaptics.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 0485e6b..19dc87f 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -372,8 +372,13 @@ static int synaptics_resolution(struct psmouse *psmouse)
>   		}
>   	}
>
> -	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 &&
> -	    SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c)) {
> +	if (SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c) &&
> +	    (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 ||
> +	     /* Firmware v8.1 doesn't stand the previous checks, though has
> +	      * been proven to report correct min coordinates.
> +	      *     https://bugzilla.kernel.org/show_bug.cgi?id=91541 */
> +	     (SYN_ID_MAJOR(priv->identity) == 8 &&
> +	      SYN_ID_MINOR(priv->identity) == 1))) {

Hmm... this can be actually read as:
+	     SYN_ID_FULL(priv->identity) == 0x801)) {

Cheers,
Benjamin

>   		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MIN_COORDS, resp)) {
>   			psmouse_warn(psmouse,
>   				     "device claims to have min coordinates query, but I'm not able to read it.\n");
>
