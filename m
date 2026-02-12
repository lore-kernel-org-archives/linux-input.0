Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940BE285058
	for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770874279; cv=none; b=VTpWGkoled90AUdm1pIu4qoMJD6goTpL+R9G2pSfJaOlMQKjLmG4ME/4e3fs3/NwXrJ3Dh+AbEKEcTOeK1b/xr2Snc8xwAtOxrUM9bFyH9iTah07I1oMAUV1HtOLQqhAEigIIanCfTi1Apw91RW6U5fZ2VS2o/0twgzggrqi3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770874279; c=relaxed/simple;
	bh=IPj99+CAjQCFOyC62JeYeciGSmJzGTFGySVzAYJSdms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dutFAQes1XN+6oKT4nf/yYYiR5JJlk1AlWQLQUW3c1rAuhndgVYz+nSFJu5Fg0ymmQVYtRwbxghLzKetmgEuRk02TA71U0RC079LddDL896pDMkYfgE9Kr4mOClf987uCJd5Y4FYvAIb5K5D+N2c6kDvCXTYPX6to/6rOntY9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C/XpT4P5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/XpT4P5"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee0291921so58034975e9.3
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 21:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770874275; x=1771479075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WF/dx0Rr8xIVi+ZgBnigIYzsCPl9NNLZZ4DZuS/3Rw0=;
        b=C/XpT4P5pFVsw+hqQMAvc0kzPMZFOwTWsY+XyCjw8u/QLvHQO+NxwE8YrdvofY2PkR
         XYNG0/CC/mJRCoQ0kuvhyCmAHMUyMxXgi6PE1C2hKHfZizOVEdOgmHZnOa+O8SouaDMt
         UaFYvWTZYkcP+ips7Saho90SMswRx6RDPhRCzxtaQzre6oeG7K3PQGxu9tuZM9a4R1En
         Bsik0fLpp291pOfRiAg5gtYGlqeQyoLOl489TpC/rvuLoAB8gB0qgF3xlcgDecO4OWKW
         Cbh2mG5oaXEWF0rUWnKrFg7XKlyzYrz7IBdsSkLNXfZQY3NNAMfJ4E3t5D45I5cbcwRu
         W9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770874275; x=1771479075;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF/dx0Rr8xIVi+ZgBnigIYzsCPl9NNLZZ4DZuS/3Rw0=;
        b=G5F2ESS7YewHfGUIj3GqGci14xrf3VsrLC6DCvS8vLE7xw9GXROiRKmeBgWLLxQ2uw
         AS//dJ5OF/MjAsyXtTLoadv/2zdvBxWa97DaAeclqR4Tn3Gailo/0fA5y0sFYi9LDet0
         qQDUCsbecoDnlDchudUb53mco0VVumxR9uMg+n0taprI7e1dEvp37b7wbuqgZwxhR50I
         VR/kwAKlLUR04pDHdLvDKiCSLDOsGy7RcJAXl4sCBVyIPDyN1fRlxtrlgzEnYjpvwAli
         I4gJvZnYseKlCptbpIMSv6StAEnQNxKvQfacblKxenEnETnXOuiy26rFVE/sNRxnxcz2
         Go7A==
X-Forwarded-Encrypted: i=1; AJvYcCUopaGvvgwwFeZsl2iGc1a4wGZOfZisFQQLRP450b2S5n0dzDE2XESiRBvWf8tvEh5sYBh3L1MF3IPGwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJsIW7KKDiL9GM/xMFD3Z0Q/3nbjwYkKB+Ma+B1lGp09gN6D+b
	lO4brlVfVM6E8SCp648K2PDP91HF8LRU6DzCHEP8Y2K17iZ+eppWmOpl04pv05yiVo7TkYzZ0lm
	BEqfB
X-Gm-Gg: AZuq6aLJ1vDCYcI6HgxQIA9pvaTSk34H14uCVm/4ahdqgJsqz20lFWB4vJ7QbGgFj3E
	zsIUWiTBKO6VmnHUpAYu8mCGK0dendrxoq03G2XWSYGFH+9oLFDgIln9z1BjFTYc/dJUxCkywzk
	JMY/na34CGuAyonbWI4iquAu2U0c/Gar61ax8e0b7WeloyvIZMpkGUjS0sTvMhEl3+i9XYk4WFC
	EtIOx+XU7XB4tjs5FkJcBbRNZUSUycPSNcP7Ag9l4WL28Kn8gHjX56wP6RFOPUxl5V4gtkDyb+c
	6az83WQGilKuTeLrLiO7px2oUViS3MJJhYvAfkkCFintbcUnvwjnFkec5WWQ3I6w2NoDSSAesUR
	flEkDmzEEl6yXQQ+W9Tj3TCP0Vomjcioe0QSLDPNvlA3G79NCzeOCddLOFocY00VQcmA7Lq4q1l
	tacDetCER5sp1/zqA1RPQD8dfO8fIP
X-Received: by 2002:a05:600c:5287:b0:476:d494:41d2 with SMTP id 5b1f17b1804b1-48365716538mr18082855e9.29.1770874274694;
        Wed, 11 Feb 2026 21:31:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd1bsm187141565e9.6.2026.02.11.21.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 21:31:14 -0800 (PST)
Date: Thu, 12 Feb 2026 08:31:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Ivan Gorinov <linux-kernel@altimeter.info>,
	Jiri Kosina <jikos@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] HID: winwing: Enable rumble effects
Message-ID: <202602120209.xYKh9QQp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211053116.GA20357@altimeter-info>

Hi Ivan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Gorinov/HID-winwing-Enable-rumble-effects/20260211-133322
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20260211053116.GA20357%40altimeter-info
patch subject: [PATCH RESEND] HID: winwing: Enable rumble effects
config: parisc-randconfig-r071-20260211 (https://download.01.org/0day-ci/archive/20260212/202602120209.xYKh9QQp-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202602120209.xYKh9QQp-lkp@intel.com/

smatch warnings:
drivers/hid/hid-winwing.c:235 winwing_haptic_rumble() warn: address of NULL pointer 'data->hdev'
drivers/hid/hid-winwing.c:308 winwing_haptic_rumble_cb() warn: can 'data' even be NULL?
drivers/hid/hid-winwing.c:339 winwing_init_ff() warn: variable dereferenced before check 'data' (see line 333)

vim +235 drivers/hid/hid-winwing.c

c4c97b07cd09c03 Ivan Gorinov 2026-02-11  221  static int winwing_haptic_rumble(struct winwing_drv_data *data)
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  222  {
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  223  	__u8 *buf;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  224  	__u8 m;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  225  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  226  	if (!data)
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  227  		return -EINVAL;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  228  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  229  	buf = data->report_rumble;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  230  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  231  	if (!buf)
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  232  		return -EINVAL;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  233  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  234  	if (!data->hdev) {
c4c97b07cd09c03 Ivan Gorinov 2026-02-11 @235  		hid_err(data->hdev, "data->hdev == NULL\n");
                                                                ^^^^^^^^^^
This doesn't end up getting dereferenced because of dev_err() magic
but passing a NULL here is pointless.

c4c97b07cd09c03 Ivan Gorinov 2026-02-11  236  		return -EINVAL;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  237  	}
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  238  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  239  	if (!data->hdev->ll_driver) {
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  240  		hid_err(data->hdev, "data->hdev->ll_driver == NULL\n");
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  241  		return -EINVAL;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  242  	}
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  243  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  244  	m = convert_magnitude(data->rumble.strong_magnitude);
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  245  	if (m != data->rumble_left) {
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  246  		int ret;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  247  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  248  		buf[0] = 0x02;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  249  		buf[1] = 0x01;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  250  		buf[2] = 0xbf;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  251  		buf[3] = 0x00;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  252  		buf[4] = 0x00;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  253  		buf[5] = 0x03;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  254  		buf[6] = 0x49;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  255  		buf[7] = 0x00;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  256  		buf[8] = m;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  257  		buf[9] = 0x00;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  258  		buf[10] = 0;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  259  		buf[11] = 0;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  260  		buf[12] = 0;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  261  		buf[13] = 0;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  262  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  263  		ret = hid_hw_output_report(data->hdev, buf, 14);
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  264  		if (ret < 0) {
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  265  			hid_err(data->hdev, "error %d (%*ph)\n", ret, 14, buf);
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  266  			return ret;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  267  		}
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  268  		data->rumble_left = m;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  269  	}
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  270  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  271  	m = convert_magnitude(data->rumble.weak_magnitude);
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  272  	if (m != data->rumble_right) {
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  273  		int ret;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  274  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  275  		buf[0] = 0x02;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  276  		buf[1] = 0x03;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  277  		buf[2] = 0xbf;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  278  		buf[3] = 0x00;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  279  		buf[4] = 0x00;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  280  		buf[5] = 0x03;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  281  		buf[6] = 0x49;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  282  		buf[7] = 0x00;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  283  		buf[8] = m;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  284  		buf[9] = 0x00;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  285  		buf[10] = 0;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  286  		buf[11] = 0;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  287  		buf[12] = 0;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  288  		buf[13] = 0;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  289  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  290  		ret = hid_hw_output_report(data->hdev, buf, 14);
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  291  		if (ret < 0) {
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  292  			hid_err(data->hdev, "error %d (%*ph)\n", ret, 14, buf);
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  293  			return ret;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  294  		}
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  295  		data->rumble_right = m;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  296  	}
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  297  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  298  	return 0;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  299  }
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  300  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  301  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  302  static void winwing_haptic_rumble_cb(struct work_struct *work)
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  303  {
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  304  	struct winwing_drv_data *data;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  305  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  306  	data = container_of(work, struct winwing_drv_data, rumble_work);
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  307  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11 @308  	if (data)

"data" can't be NULL.  It's work minus an offset.

c4c97b07cd09c03 Ivan Gorinov 2026-02-11  309  		winwing_haptic_rumble(data);
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  310  }
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  311  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  312  static int winwing_play_effect(struct input_dev *dev, void *context,
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  313  		struct ff_effect *effect)
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  314  {
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  315  	struct winwing_drv_data *data = (struct winwing_drv_data *) context;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  316  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  317  	if (effect->type != FF_RUMBLE)
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  318  		return 0;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  319  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  320  	if (!data)
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  321  		return -EINVAL;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  322  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  323  	data->rumble = effect->u.rumble;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  324  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  325  	return schedule_work(&data->rumble_work);
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  326  }
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  327  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  328  static int winwing_init_ff(struct hid_device *hdev, struct hid_input *hidinput)
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  329  {
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  330  	struct winwing_drv_data *data;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  331  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  332  	data = (struct winwing_drv_data *) hid_get_drvdata(hdev);
c4c97b07cd09c03 Ivan Gorinov 2026-02-11 @333  	data->report_rumble = devm_kzalloc(&hdev->dev, MAX_REPORT, GFP_KERNEL);
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  334  	data->rumble_left = -1;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  335  	data->rumble_right = -1;
                                                ^^^^^^^^^^^^^^^^^^
Dereferences here.

c4c97b07cd09c03 Ivan Gorinov 2026-02-11  336  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  337  	input_set_capability(hidinput->input, EV_FF, FF_RUMBLE);
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  338  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11 @339  	if (!data)
                                                    ^^^^^^
Checked too late.

c4c97b07cd09c03 Ivan Gorinov 2026-02-11  340  		return -EINVAL;
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  341  
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  342  	return input_ff_create_memless(hidinput->input, data,
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  343  			winwing_play_effect);
c4c97b07cd09c03 Ivan Gorinov 2026-02-11  344  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

