From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko.stuebner@bq.com>
Subject: Re: [PATCH] Input: zforce_ts - fix playload length check
Date: Mon, 27 Jul 2015 23:35:23 +0200
Message-ID: <9298777.SjHtUzmdFZ@diego>
References: <20150727210619.GA2825@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:50576 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753954AbbG0Vf1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 17:35:27 -0400
In-Reply-To: <20150727210619.GA2825@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>, linux-kernel@vger.kernel.org

Hi Dmitry,

Am Montag, 27. Juli 2015, 14:06:19 schrieb Dmitry Torokhov:
> Commit 7d01cd261c76f95913c81554a751968a1d282d3a ("Input: zforce - don't
> overwrite the stack") attempted to add a check for payload size being too
> large for the supplied buffer. Unfortunately with the currently selected
> buffer size the comparison is always false as buffer size is larger than
> the value a single byte can hold, and that results in compiler warnings.
> Additionally the check was incorrect as it was not accounting for the
> already read 2 bytes of data stored in the buffer.
> 
> Fixes: 7d01cd261c76f95913c81554a751968a1d282d3a
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> This seems to shut up my GCC, I wonder if it is going to work gfor
> everyone or we better add BUILD_BUG_ON(FRAME_MAXSIZE < 257) and a
> comment and remove check.

needed a bit to get to know my old zforce driver again ;-)


I may be blind, but currently I fail to see what problem the original patch 
actually tries to fix.

buf[PAYLOAD_LENGTH] is an u8, so the max value it can contain is 255. The 
i2c_master_recv reads buf[PAYLOAD_LENGTH]-bytes into the buffer starting at 
buf[PAYLOAD_BODY] (= buf[2]). So it reads at max 255 bytes into a 257 byte big 
buffer starting at index 2.

zforce_read_packet, also is an internal function used only by the interrupt 
handler, which always only calls it with a buffer of FRAME_MAXSIZE size.


The original patch said "If we get a corrupted packet with PAYLOAD_LENGTH > 
FRAME_MAXSIZE, we will silently overwrite the stack." but payload_length can 
never actually be greater than the buffer size?


Very confused
Heiko

>  drivers/input/touchscreen/zforce_ts.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/zforce_ts.c
> b/drivers/input/touchscreen/zforce_ts.c index 2554efd..542ff02 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -441,7 +441,9 @@ static int zforce_read_packet(struct zforce_ts *ts, u8
> *buf) goto unlock;
>  	}
> 
> -	if (buf[PAYLOAD_LENGTH] == 0 || buf[PAYLOAD_LENGTH] > FRAME_MAXSIZE) {
> +	if (buf[PAYLOAD_LENGTH] == 0 ||
> +	    (FRAME_MAXSIZE - 2 < 255 &&
> +	     buf[PAYLOAD_LENGTH] > FRAME_MAXSIZE - 2)) {
>  		dev_err(&client->dev, "invalid payload length: %d\n",
>  			buf[PAYLOAD_LENGTH]);
>  		ret = -EIO;

