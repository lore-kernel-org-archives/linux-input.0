From: Andreas Bosch <linux@progandy.de>
Subject: Re: [PATCH] Alps source code update
Date: Fri, 24 Oct 2014 10:03:58 +0200
Message-ID: <544A07EE.80407@progandy.de>
References: <1414102883-11084-1-git-send-email-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:62675 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbaJXIEE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Oct 2014 04:04:04 -0400
Received: by mail-qc0-f181.google.com with SMTP id r5so241753qcx.26
        for <linux-input@vger.kernel.org>; Fri, 24 Oct 2014 01:04:02 -0700 (PDT)
In-Reply-To: <1414102883-11084-1-git-send-email-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>, dmitry.torokhov@gmail.com, cernekee@gmail.com, dturvene@dahetral.com
Cc: linux-input@vger.kernel.org, ndevos@redhat.com, jclift@redhat.com, Masaki Ota <masaki.ota@jp.alps.com>

Am 24.10.2014 um 00:21 schrieb Masaki Ota:
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> - Support Alps Button-less Touchpad device(Rushmore and SS4). New device type and a data decode logic were added.
> ---
>   drivers/input/mouse/alps.c | 1680 +++++++++++++++++++++++++++++++++++---------
>   drivers/input/mouse/alps.h |  263 ++++++-
>   2 files changed, 1574 insertions(+), 369 deletions(-)
Hello,

This patch is reversing changes introduced in commit 
02d04254a5dfb8de1459805c3433cd0e9e4853d7 (Input: alps - use struct 
input_mt_pos to track coordinates), maybe some others, too. Is this 
deliberate?

These are two examples of that.
> [...]
>
>    * The bitmaps don't have enough data to track fingers, so this function
>    * only generates points representing a bounding box of at most two contacts.
> - * These two points are returned in fields->mt.
> + * These two points are returned in x1, y1, x2, and y2.
>    */
>   static void alps_process_bitmap_dolphin(struct alps_data *priv,
> -					struct alps_fields *fields)
> +					struct alps_fields *fields,
> +					int *x1, int *y1, int *x2, int *y2)
>   {
>   	int box_middle_x, box_middle_y;
>   	unsigned int x_map, y_map;
> @@ -309,6 +329,8 @@ static void alps_process_bitmap_dolphin(struct alps_data *priv,
>   	if (x_msb > priv->x_bits || y_msb > priv->y_bits)
>   		return;
> [...]
>
and
> [...]
>
> @@ -168,27 +351,35 @@ struct alps_data {
>   	int addr_command;
>
> [...]
>
> -	struct alps_fields f;
> +	int x1, x2, y1, y2;
> +	int fingers;
>   	u8 quirks;
>   	struct timer_list timer;
> [...]
