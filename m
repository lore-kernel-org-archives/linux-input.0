From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCHv5] input: ROHM BU21013 touch panel controller support
Date: Sat, 02 Oct 2010 09:25:41 +0200
Message-ID: <4CA6DE75.8010508@euromail.se>
References: <1285930790-2206-1-git-send-email-naveen.gaddipati@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:49480 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751715Ab0JBHZ6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Oct 2010 03:25:58 -0400
In-Reply-To: <1285930790-2206-1-git-send-email-naveen.gaddipati@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar G <naveen.gaddipati@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, STEricsson_nomadik_linux@list.st.com, linux-input@vger.kernel.org, tsoni@codeaurora.org

On 10/01/2010 12:59 PM, Naveen Kumar G wrote:
[...]

> +static int bu21013_do_touch_report(struct bu21013_ts_data *data)
> +{
> +	u8	buf[LENGTH_OF_BUFFER];
> +	unsigned int pos_x[2], pos_y[2];
> +	bool	has_x_sensors, has_y_sensors;
> +	int	finger_down_count = 0;
> +	int	i;
> +
> +	if (data == NULL)
> +		return -EINVAL;
> +
> +	if (bu21013_read_block_data(data, buf) < 0)
> +		return -EINVAL;
> +
> +	has_x_sensors = hweight32(buf[0] & BU21013_SENSORS_EN_0_7);
> +	has_y_sensors = hweight32(((buf[1] & BU21013_SENSORS_EN_8_15) |
> +		((buf[2] & BU21013_SENSORS_EN_16_23) << SHIFT_8)) >> SHIFT_2);
> +	if (!has_x_sensors || !has_y_sensors)
> +		return 0;


I believe this line will lead to fingers stuck in the down position.

Henrik
