From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v3 2/3] input: appletouch: implement sensor data smoothing
Date: Sun, 09 Mar 2014 14:54:52 +0100
Message-ID: <531C72AC.5030909@euromail.se>
References: <52D9DE7A.7040509@gmail.com> <531C042D.5090103@gmail.com> <531C0797.9060908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:50606 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaCINu1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Mar 2014 09:50:27 -0400
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id 61C18EB652
	for <linux-input@vger.kernel.org>; Sun,  9 Mar 2014 14:50:25 +0100 (CET)
In-Reply-To: <531C0797.9060908@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Clinton Sprain <clintonsprain@gmail.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Clinton,

> Use smoothed version of sensor array data to calculate movement and add weight
> to prior values when calculating average. This gives more granular and more
> predictable movement.

Great patch, just one thing:

> +		/* Handle other edge. */
> +		smooth_tmp[nb_sensors + 7] = (smooth[nb_sensors + 7] + smooth[nb_sensors + 6]) >> 1;
> +
> +		for (i = 0; i < nb_sensors + 7; i++)
> +			smooth[i] = smooth_tmp[i];

Should be "< nb_sensors + 8" here, no?

Thanks,
Henrik

