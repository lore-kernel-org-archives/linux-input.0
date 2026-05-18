Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8E45104C
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110730; cv=none; b=g/oig/R8/TzrR9AX0cY1HNLSaZHQfAtu/Ero6JzAsP/lghtym9aqbUB7+CP93q5JV9K/941pJG6zVKnfqNXsO6K7j3pJz6OaYM+FG73BD4B38LPun+Kzoe6uXq63Nrcqxev/Z1avu90X9aDr15s+rzHZWVSgv3MkvmE3HAfiTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110730; c=relaxed/simple;
	bh=Ct1XPW+07i0pZ7asi7gWx2asaw42fCoDCYGH0AX5810=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N11TKav04m6f3+KiuiZOB8I8tbR8ap4k2l21tviCm9uaAym7va3A90QT1kMh7VA7hLUyzAPCRO73LmWe6ck4Mn6oktbK9W+fBkaurS4Cm3Dht+eUOuDsoOb/Its7Wi93s3iWloAbv/F28yKcd6uFu12OLG2xQSZRxtJyVe7eLGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AA6iJQGL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA6iJQGL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so23368405e9.2
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 06:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779110727; x=1779715527; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wOzJlgLvuDBYw1uz4Wf5xiNrLjjRfOoAtR4Oj9ryq0=;
        b=AA6iJQGLCEyDzUhd5XI71Q0DNAVCmRnOicpwrctQzwJpFsv4zPA8BRPuN4foc7Q7xJ
         6flk/B48DfJMZvgcVnA1EXa2c4mCpMa+bDNrqxHyM6Q11e+tpfBV2ezArFD48Ry+8fBd
         yv5clx/QYh+8JN+RdFc/rFF6W3usLTuFA/6qFcdE2aYFQNaOGMuGAM3nQM2N9sTYfWE+
         uByZpNpyOhPUiyyyjjWF+0BECp6UBW5HdKdWmMidd5FQygxQyWFb58RJbh8kAWS6ca+3
         j4LUIBb/IVo+P3YoK3WtnbhLfLwLxVTryFpwOsH0T8MC5YHACTIxFA6s79Gc16a3AmFX
         nkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110727; x=1779715527;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wOzJlgLvuDBYw1uz4Wf5xiNrLjjRfOoAtR4Oj9ryq0=;
        b=bVqqToo2HAWM25EkeZXRZ/k9yDZxqEFQt+2QSBZriISxe5rkExCR1RfCj8rgcQNGqh
         G9PdJcNf+g3aLMqGlDEDbReU7jGzS/G1obI9EdSqCShf374ABT8PkNpgY2/wIgo4ZpWD
         oj0xUohOXdICaOWfBCTq4XC3gp09ZpvZ4FtCu+Vhm6CWIxsPcIiz456zzh3g2W38dJkz
         o+GIF0vwip6VCG6jO6nTmUgkOGKwB9CmgSKZg7YgXnY3sVaqX8L8Tvwd1byH2STbOdFG
         RGduAz1lFaWbvBHSJqQ7P4ZxeOFhtLaJU9OWz+OYYVqImHMQGsVIV2qvLFUwvRH4TKcp
         sPAg==
X-Gm-Message-State: AOJu0Yzc9/IzkoFr+9Kdii2BGeNhrKYAxMA2EY+HYkLP6hrRXWhpILRM
	x46GUMSm7K/0Vc2ibK52TLRdFXZS6apbyaj1zkUMUV6p2ppQYCWQQPnn
X-Gm-Gg: Acq92OGOB98Jb8gZcb5Dwj1XFy4dIBend8xVWq8mA/s98CdCz/8c/UdWpmtMKj6Pmj9
	ZsL3rITnLYpbGtBETPOtL0qTOg59dr/JuId3J/hQhA1XuohTSKDGT7YURBlz8zMboSbS0Z2xzJt
	dU9qLs7cUqaTGNvnCbqhLR9p0liEGddkbIxsH8jalLn/yt5avXkEM4BtjEguktNxJ4C4FXya9L0
	Uh7B8xJW+Bm0LKcgJtX4viWHa7LXgLuylIcSpY57P1kYec+B9VohQu1/b+CjNaYX7s34d8Ctvv/
	Qu7wJVH3gPFzc3Um37arN7MuWIczx/MoPH99D92cHMpMNcz8d3Bad2giz2frDAIO3CuJ12nuBdD
	8fA+avAc2X/JdxI7viN6ZHatzwCKse1YEwySe3lANMcN6tOyegEiU0oKaXc7oDU5WxVUqw+IYkh
	Q6kLCkeSIBWn3+H9jnX0I=
X-Received: by 2002:a05:600c:a293:b0:48f:e6de:1cc6 with SMTP id 5b1f17b1804b1-48fe6de1e03mr144283255e9.32.1779110726434;
        Mon, 18 May 2026 06:25:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab527asm283095945e9.11.2026.05.18.06.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:25:25 -0700 (PDT)
Date: Mon, 18 May 2026 16:25:22 +0300
From: Dan Carpenter <error27@gmail.com>
To: Hyungwoo Yang <hyungwoo.yang@intel.com>
Cc: linux-input@vger.kernel.org
Subject: [bug report] HID: intel-ish: enable raw interface to HID devices on
 ISH
Message-ID: <agsTQoL1WM4l3AZ3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Hyungwoo Yang,

Commit e19595fcabb5 ("HID: intel-ish: enable raw interface to HID
devices on ISH") from Mar 4, 2019 (linux-next), leads to the
following Smatch static checker warning:

	drivers/hid/intel-ish-hid/ishtp-hid-client.c:225 process_recv()
	warn: potentially one past the end of array 'client_data->hid_devices[i]'

drivers/hid/intel-ish-hid/ishtp-hid-client.c
    66 static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
    67                          size_t data_len)
    68 {
    69         struct hostif_msg *recv_msg;
    70         unsigned char *payload;
    71         struct device_info *dev_info;
    72         int i, j;
    73         size_t        payload_len, total_len, cur_pos, raw_len, msg_len;
    74         int report_type;
    75         struct report_list *reports_list;
    76         struct report *report;
    77         size_t report_len;
    78         struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
    79         int curr_hid_dev = client_data->cur_hid_dev;
    80         struct ishtp_hid_data *hid_data = NULL;
    81         struct hid_device *hid = NULL;
    82 
    83         payload = recv_buf + sizeof(struct hostif_msg_hdr);
    84         total_len = data_len;
    85         cur_pos = 0;
    86 
    87         do {
    88                 if (cur_pos + sizeof(struct hostif_msg) > total_len) {
    89                         dev_err(cl_data_to_dev(client_data),
    90                                 "[hid-ish]: error, received %u which is less than data header %u\n",
    91                                 (unsigned int)data_len,
    92                                 (unsigned int)sizeof(struct hostif_msg_hdr));
    93                         ++client_data->bad_recv_cnt;
    94                         ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
    95                         break;
    96                 }
    97 
    98                 recv_msg = (struct hostif_msg *)(recv_buf + cur_pos);
    99                 payload_len = recv_msg->hdr.size;
    100 
    101                 /* Sanity checks */
    102                 if (cur_pos + payload_len + sizeof(struct hostif_msg) >
    103                                 total_len) {
    104                         ++client_data->bad_recv_cnt;
    105                         report_bad_packet(hid_ishtp_cl, recv_msg, cur_pos,
    106                                           payload_len);
    107                         ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
    108                         break;
    109                 }
    110 
    111                 hid_ishtp_trace(client_data,  "%s %d\n",
    112                                 __func__, recv_msg->hdr.command & CMD_MASK);
    113 
    114                 switch (recv_msg->hdr.command & CMD_MASK) {
    115                 case HOSTIF_DM_ENUM_DEVICES:
    116                         if ((!(recv_msg->hdr.command & ~CMD_MASK) ||
    117                                         client_data->init_done)) {
    118                                 ++client_data->bad_recv_cnt;
    119                                 report_bad_packet(hid_ishtp_cl, recv_msg,
    120                                                   cur_pos,
    121                                                   payload_len);
    122                                 ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
    123                                 break;
    124                         }
    125                         client_data->hid_dev_count = (unsigned int)*payload;
    126                         if (!client_data->hid_devices)
    127                                 client_data->hid_devices = devm_kcalloc(
    128                                                 cl_data_to_dev(client_data),
    129                                                 client_data->hid_dev_count,
    130                                                 sizeof(struct device_info),
    131                                                 GFP_KERNEL);

We only allocate the client_data->hid_devices buffer one time, and
then re-use it after that.

1) However, how do we know that the new value of client_data->hid_dev_count
   assigned on line 125 is the same or smaller than the previous value?
2) I think we need to update client_data->num_hid_devices as well since
   that has to be == client_data->hid_dev_count.  Also we assume that if
   client_data->num_hid_devices is non-zero then client_data->hid_devices
   was allocated successfully.

Or maybe client_data->hid_devices is always NULL here and the check
can be removed that way?  In that case we just need to make a cleanup
and there is no security bug, however there is another security issue
below.

    132                         if (!client_data->hid_devices) {
    133                                 dev_err(cl_data_to_dev(client_data),
    134                                 "Mem alloc failed for hid device info\n");
    135                                 wake_up_interruptible(&client_data->init_wait);
    136                                 break;
    137                         }
    138                         for (i = 0; i < client_data->hid_dev_count; ++i) {
    139                                 if (1 + sizeof(struct device_info) * i >=
    140                                                 payload_len) {
    141                                         dev_err(cl_data_to_dev(client_data),
    142                                                 "[hid-ish]: [ENUM_DEVICES]: content size %zu is bigger than payload_len %zu\n",
    143                                                 1 + sizeof(struct device_info)
    144                                                 * i, payload_len);


3) This if statement is testing if we are reading beyond the end of the
   buffer, but it just prints an error message and continues reading.
   So it is an information leak.  It should error out.

    145                                 }
    146 
    147                                 if (1 + sizeof(struct device_info) * i >=
    148                                                 data_len)
    149                                         break;

4) It's weird that if we have an overflow in this inner loop we break but
   potentially still keep iterating in the outer loop.

    150 
    151                                 dev_info = (struct device_info *)(payload + 1 +
    152                                         sizeof(struct device_info) * i);
    153                                 if (client_data->hid_devices)
                                            ^^^^^^^^^^^^^^^^^^^^^^^^
5) It's not a bug, but this NULL check can be removed.  It triggers a
   static checker warning about inconsistent NULL checking.

regards,
dan carpenter

    154                                         memcpy(client_data->hid_devices + i,
    155                                                dev_info,
    156                                                sizeof(struct device_info));
    157                         }
    158 
    159                         client_data->enum_devices_done = true;
    160                         wake_up_interruptible(&client_data->init_wait);
    161 

This email is a free service from the Smatch-CI project [smatch.sf.net].

