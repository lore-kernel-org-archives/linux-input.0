From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Mon, 11 Apr 2016 01:24:28 -0700
Message-ID: <20160411082428.GA26066@dtor-ws>
References: <1458883269-3218-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36165 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbcDKIYd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Apr 2016 04:24:33 -0400
Content-Disposition: inline
In-Reply-To: <1458883269-3218-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>
Cc: rydberg@euromail.se, grant.likely@linaro.org, robh+dt@kernel.org, jeesw@melfas.com, bleung@chromium.org, scott.liu@emc.com.tw, jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org

Hi Jeffrey,

On Fri, Mar 25, 2016 at 01:21:09PM +0800, jeffrey.lin wrote:
> +#define MAX_PACKET_SIZE		60
...
> +#define RAYDIUM_FW_PAGESIZE	128
...
> +
> +static int raydium_i2c_send(struct i2c_client *client,
> +	u8 addr, u8 *data, size_t len)
> +{
> +	u8 buf[MAX_PACKET_SIZE + 1];
> +	int tries = 0;
> +
> +	if (len > MAX_PACKET_SIZE)
> +		return -EINVAL;
...
> +static int raydium_i2c_fw_write_page(struct i2c_client *client,
> +				const void *page)
> +{
> +	static const u8 ack_ok[] = { 0x55, 0xAA };
> +	u8 buf[2];
> +	int retry;
> +	int error;
> +
> +	for (retry = 0; retry < MAX_FW_UPDATE_RETRIES; retry++) {
> +		error = raydium_i2c_send(client, CMD_BOOT_WRT,
> +			(u8 *)page, RAYDIUM_FW_PAGESIZE);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"BLDR Write Page failed: %d\n", error);
> +			continue;
> +		}

Given the above definitions of MAX_PACKET_SIZE and
RAYDIUM_FW_PAGESIZE I do not believe that firmware update is working.
What is the biggest buffer that can be sent to the device? Maybe we
should allocate it dynamically?

I am also wondering about formatting command structure as byte sequence.
Would it be better to define it as:

struct raidium_cmd {
	u32 bank;
	int len;
	u8 cmd[RAIDIUM_MAX_CMD_LEN];
}

What is the longest command that the controller supports?

(Do not resubmit the driver yet, let's discuss first).

Thanks.

-- 
Dmitry
