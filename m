From: Clinton Sprain <clintonsprain@gmail.com>
Subject: Re: [PATCH v3 2/3] input: appletouch: implement sensor data smoothing
Date: Sun, 09 Mar 2014 10:03:08 -0500
Message-ID: <531C82AC.4010104@gmail.com>
References: <52D9DE7A.7040509@gmail.com> <531C042D.5090103@gmail.com> <531C0797.9060908@gmail.com> <531C72AC.5030909@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:53319 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbaCIPDL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Mar 2014 11:03:11 -0400
Received: by mail-ig0-f176.google.com with SMTP id uy17so6132747igb.3
        for <linux-input@vger.kernel.org>; Sun, 09 Mar 2014 08:03:10 -0700 (PDT)
In-Reply-To: <531C72AC.5030909@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Ah, you are correct. Good catch. The last few far edge values are guaranteed to be 0 on all but the older 17" devices so I didn't see anything askew.

Thanks,
Clinton

On 03/09/2014 08:54 AM, Henrik Rydberg wrote:
> Hi Clinton,
> 
>> Use smoothed version of sensor array data to calculate movement and add weight
>> to prior values when calculating average. This gives more granular and more
>> predictable movement.
> 
> Great patch, just one thing:
> 
>> +		/* Handle other edge. */
>> +		smooth_tmp[nb_sensors + 7] = (smooth[nb_sensors + 7] + smooth[nb_sensors + 6]) >> 1;
>> +
>> +		for (i = 0; i < nb_sensors + 7; i++)
>> +			smooth[i] = smooth_tmp[i];
> 
> Should be "< nb_sensors + 8" here, no?
> 
> Thanks,
> Henrik
> 
