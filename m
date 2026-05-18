Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7040584E
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112281; cv=none; b=hI4F8R+0NjP9l9w1Nz7U9DTzGrgVPWvC6ZasWFctbml0zrLDSkbkvKRNsq5c0G8m3fCDQKKTEvS51/n9zEi/RJYZ9LBozYcY3jwLvBo68g388vkbWq+uPVLjaHaCsnsgil9hDxXZRRAXFOhPBHQa1m+mv7itQOUi51Amf5G1xkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112281; c=relaxed/simple;
	bh=dZF1/boZyKhaadSKPsojux2hnlmrSXPw8VqdS/VIT/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQoYaVLyk1Yb4umha36TmtIBOW8PFcVB75yhPCCx0YaxDfLQCtC7zjv//vzJGKKQlwF6XKSnfUuAeHFXbKrDgewyR0lH4Cl6H89gYH6PjRDOI8rRRLYkfGpwdCrIz4JczysLrEnD/0RNaQWuzA0d1wX+BvX3IMygalwQwqPtj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGfzScNN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGfzScNN"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso17615765e9.2
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779112279; x=1779717079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ws5GMGt7LSsYSgZ6xku/fitdsXTS4I9e5Gsw1B47UAc=;
        b=kGfzScNNCrwo6AHb3bw1XM22UzfKiD6ASR/DFu9qLZ235IdsgEcF7gIvFZ54XWK36b
         OYfKt6oVcIGU858KKMLeLsAek9R8uricwrYmmvDe7IvDhADToN2BK+2LCm/q6lNQgVjv
         diNjfVPpAn9Jbqk43dcGj7Pp16GE9nqFvmtzC2PLBfQkCoBfY+yBdQy34dTgXjP85HT2
         YFixVB9ltDnhYnXezLGPRy5TrJLpS800Yi0Jt1taFhr5rcXmz301CuphzxiovYXKnAzP
         W5kbXlTH54jAK7mI5B/DcKj69UbGhHbXSHCK898WGy3vyAwkrpwoLb0bgibCou0RJA/N
         orig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112279; x=1779717079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ws5GMGt7LSsYSgZ6xku/fitdsXTS4I9e5Gsw1B47UAc=;
        b=o40gxLtuXocI5SqpZpw1rQbnX2A3WWLCApx/P5mWc1Pjc6ynerFCR/iajw7PoQtAHJ
         zqXF5gk/zCcLAClK4jzQ32NQFo3m4fnst1lli75YEs0KERymR/FOpM082AUJy+H09Zzs
         EZjT5o2lZ6qi1RUmxHkqpXMgi7YOLg9SjIuBPSKnAeRwK/4HIBD7Zeidi+YeB4dAQvAa
         Hfd55aZBK0UncyC0sK22fNvSELrwqt7CxORR20sa8dcp/YBxVX2J5T6I6EUUvkVtag+m
         iZ9cqJiGymd0Bn6IkMzwMlFLUMkV8+RK/os8JYmZ4caRFz5lZpZDbUEqqZeP+PIKZZju
         M1PA==
X-Gm-Message-State: AOJu0YwzGFTbKlAJBkJjpyLzmMlLHjYsAL+cqpFi9ttLjiE6H2zpgcZQ
	2pXDuXWIiR/qkvnOpABXuJaY80ohg82VJGxnKJ3hkWify43UHvxrq3uO
X-Gm-Gg: Acq92OH56YLe9NMHAU5OZB9ts8aqH0+XxN1ujDjhBLWdtHIX5UJhmfma0KDOTXrn8SC
	9rquxxO8UjaRo94Fwge3UEry3fyDAZhUEqFaVLPRg5In1/lyJzeUKo4j6Y5BzJJn0AvZ6dwRSyJ
	az1Y5EoD7jUB5ZLlOoXp8hvCLKyXvjPx2bkBsEeCGnQiDKeUQANQ0UjepicjgrAMgSeXy4lFLVX
	KwRaxxrITxceeGl1qr7aTBB2kpWwWTgPpm6jdZYnWbfU+j6RJo80gZjux6jwFJGcrp1p9duzCjf
	FiRomVdfKdwyUmcyHNsIdaHl+x6uNBRT/Nn+rt/vjyUutcTtUp1t1rjcCISwaB9XSCbw82BdeMm
	oSHjDc3Suo1eDtRd5GScMvUqgsaypHBQMIqAH8m+X/fP18RoTwrPm5r+xf2wmGRP5t3B4ZWz6Z0
	Z+dp3dDhBVtE/dyN9787E=
X-Received: by 2002:a05:600c:4f8a:b0:489:ad:7b5b with SMTP id 5b1f17b1804b1-48fe62f8c6bmr233010675e9.24.1779112278592;
        Mon, 18 May 2026 06:51:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8d39esm260553085e9.7.2026.05.18.06.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:51:17 -0700 (PDT)
Date: Mon, 18 May 2026 16:51:14 +0300
From: Dan Carpenter <error27@gmail.com>
To: Zhang Lixu <lixu.zhang@intel.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org
Subject: Re: [bug report] HID: intel-ish: enable raw interface to HID devices
 on ISH
Message-ID: <agsZUixoslnf__xn@stanley.mountain>
References: <agsTQoL1WM4l3AZ3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agsTQoL1WM4l3AZ3@stanley.mountain>

This code is 7 years old now and Hyungwoo Yang's email is dead.  I know
Jiri reads mail to the list but let me add a Zhang Lixu to the CC list.

regards,
dan carpenter

On Mon, May 18, 2026 at 04:25:22PM +0300, Dan Carpenter wrote:
> Hello Hyungwoo Yang,
> 
> Commit e19595fcabb5 ("HID: intel-ish: enable raw interface to HID
> devices on ISH") from Mar 4, 2019 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	drivers/hid/intel-ish-hid/ishtp-hid-client.c:225 process_recv()
> 	warn: potentially one past the end of array 'client_data->hid_devices[i]'
> 
> drivers/hid/intel-ish-hid/ishtp-hid-client.c
>     66 static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
>     67                          size_t data_len)
>     68 {
>     69         struct hostif_msg *recv_msg;
>     70         unsigned char *payload;
>     71         struct device_info *dev_info;
>     72         int i, j;
>     73         size_t        payload_len, total_len, cur_pos, raw_len, msg_len;
>     74         int report_type;
>     75         struct report_list *reports_list;
>     76         struct report *report;
>     77         size_t report_len;
>     78         struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
>     79         int curr_hid_dev = client_data->cur_hid_dev;
>     80         struct ishtp_hid_data *hid_data = NULL;
>     81         struct hid_device *hid = NULL;
>     82 
>     83         payload = recv_buf + sizeof(struct hostif_msg_hdr);
>     84         total_len = data_len;
>     85         cur_pos = 0;
>     86 
>     87         do {
>     88                 if (cur_pos + sizeof(struct hostif_msg) > total_len) {
>     89                         dev_err(cl_data_to_dev(client_data),
>     90                                 "[hid-ish]: error, received %u which is less than data header %u\n",
>     91                                 (unsigned int)data_len,
>     92                                 (unsigned int)sizeof(struct hostif_msg_hdr));
>     93                         ++client_data->bad_recv_cnt;
>     94                         ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
>     95                         break;
>     96                 }
>     97 
>     98                 recv_msg = (struct hostif_msg *)(recv_buf + cur_pos);
>     99                 payload_len = recv_msg->hdr.size;
>     100 
>     101                 /* Sanity checks */
>     102                 if (cur_pos + payload_len + sizeof(struct hostif_msg) >
>     103                                 total_len) {
>     104                         ++client_data->bad_recv_cnt;
>     105                         report_bad_packet(hid_ishtp_cl, recv_msg, cur_pos,
>     106                                           payload_len);
>     107                         ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
>     108                         break;
>     109                 }
>     110 
>     111                 hid_ishtp_trace(client_data,  "%s %d\n",
>     112                                 __func__, recv_msg->hdr.command & CMD_MASK);
>     113 
>     114                 switch (recv_msg->hdr.command & CMD_MASK) {
>     115                 case HOSTIF_DM_ENUM_DEVICES:
>     116                         if ((!(recv_msg->hdr.command & ~CMD_MASK) ||
>     117                                         client_data->init_done)) {
>     118                                 ++client_data->bad_recv_cnt;
>     119                                 report_bad_packet(hid_ishtp_cl, recv_msg,
>     120                                                   cur_pos,
>     121                                                   payload_len);
>     122                                 ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
>     123                                 break;
>     124                         }
>     125                         client_data->hid_dev_count = (unsigned int)*payload;
>     126                         if (!client_data->hid_devices)
>     127                                 client_data->hid_devices = devm_kcalloc(
>     128                                                 cl_data_to_dev(client_data),
>     129                                                 client_data->hid_dev_count,
>     130                                                 sizeof(struct device_info),
>     131                                                 GFP_KERNEL);
> 
> We only allocate the client_data->hid_devices buffer one time, and
> then re-use it after that.
> 
> 1) However, how do we know that the new value of client_data->hid_dev_count
>    assigned on line 125 is the same or smaller than the previous value?
> 2) I think we need to update client_data->num_hid_devices as well since
>    that has to be == client_data->hid_dev_count.  Also we assume that if
>    client_data->num_hid_devices is non-zero then client_data->hid_devices
>    was allocated successfully.
> 
> Or maybe client_data->hid_devices is always NULL here and the check
> can be removed that way?  In that case we just need to make a cleanup
> and there is no security bug, however there is another security issue
> below.
> 
>     132                         if (!client_data->hid_devices) {
>     133                                 dev_err(cl_data_to_dev(client_data),
>     134                                 "Mem alloc failed for hid device info\n");
>     135                                 wake_up_interruptible(&client_data->init_wait);
>     136                                 break;
>     137                         }
>     138                         for (i = 0; i < client_data->hid_dev_count; ++i) {
>     139                                 if (1 + sizeof(struct device_info) * i >=
>     140                                                 payload_len) {
>     141                                         dev_err(cl_data_to_dev(client_data),
>     142                                                 "[hid-ish]: [ENUM_DEVICES]: content size %zu is bigger than payload_len %zu\n",
>     143                                                 1 + sizeof(struct device_info)
>     144                                                 * i, payload_len);
> 
> 
> 3) This if statement is testing if we are reading beyond the end of the
>    buffer, but it just prints an error message and continues reading.
>    So it is an information leak.  It should error out.
> 
>     145                                 }
>     146 
>     147                                 if (1 + sizeof(struct device_info) * i >=
>     148                                                 data_len)
>     149                                         break;
> 
> 4) It's weird that if we have an overflow in this inner loop we break but
>    potentially still keep iterating in the outer loop.
> 
>     150 
>     151                                 dev_info = (struct device_info *)(payload + 1 +
>     152                                         sizeof(struct device_info) * i);
>     153                                 if (client_data->hid_devices)
>                                             ^^^^^^^^^^^^^^^^^^^^^^^^
> 5) It's not a bug, but this NULL check can be removed.  It triggers a
>    static checker warning about inconsistent NULL checking.
> 
> regards,
> dan carpenter
> 
>     154                                         memcpy(client_data->hid_devices + i,
>     155                                                dev_info,
>     156                                                sizeof(struct device_info));
>     157                         }
>     158 
>     159                         client_data->enum_devices_done = true;
>     160                         wake_up_interruptible(&client_data->init_wait);
>     161 
> 
> This email is a free service from the Smatch-CI project [smatch.sf.net].
