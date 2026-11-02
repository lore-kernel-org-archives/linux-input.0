Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641041;
	b=124Aa2Itr/SALWRSBsQxBo8HTwTsNkPgTWvNT4XJjHvyGJNIZqgMRGzc7j4FWXcImYFr
	 VPJa3vpablS3oG+BdrUd88Uh9HZAo/KZwev8D5AVq+zS4GZTqCAQGzzIRg1CtDkfroOHD
	 7BkTb2g3CI4uP2M5AqkXSojyxdcQtZzM4z9o2aRBgwCrLK87mUwFJSG/i800MXJIfa/G4
	 WSCQQLUm25KJu9C2P4lssu2gehaTT2IsTl5vsdQsa9zhDgL2nf/IqptSuYBOPG20sZPED
	 yFGaYQNRqHrzsruU88Moski9gi19irluIKvXALmrhiqx48pGoHymBdjocwKZWAAAQIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=wrj6sTKkJM7jrWxrV5P1DmJmPuQKxsBc3+FZTk/V1J4=;
	b=5CwT/z2rKQpQeuZ3GqgrzRKqrJO1f+615q5Vascxs5uEn2XTdIPLgDc2X9dgPF2bev+C
	 k61Abxqqa+I5Z35bgg+4X2p8gkCiC557dut1No3ZbOp86RAd44W60RnNn2JcAGpufdywc
	 ZPB/Tnbco2XDNkAXsKayRhS96qK88vF4c0jKyopAfpuSeptBtmjAqfp0X06SSc4DcwLHo
	 3s3DajK0bQk4ObZx7u7qQOqDQq911FPmZg5vYiGzDNnRwPupAU4/tpo12aT5GudxTwjxi
	 TOOb7voUxEW8+cOcVGfNl3pNaMtoO3+laRqC833iUjSg60ufz++QHcNRQvO5gnwzy4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jfyBO+Uo;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9C606A906
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 17:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AE9C606A906
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jfyBO+Uo
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a17a332ecso5157969eec.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 09:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793641040; x=1794245840; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wrj6sTKkJM7jrWxrV5P1DmJmPuQKxsBc3+FZTk/V1J4=;
        b=jfyBO+UoERP1OS7aLFfpDk9BCf7OJFgIR+uFJGAx3ofI+CEG+gsdDCrYkWJeMG84gj
         zJ6oo7NGS5qxT25MQ0IrHoa9tPSnggd5aLj8TBCRyjcKCnCgqFcCZf9Il6aIq1W1bbgH
         aIqAlFK7ZMRhO3bOE9jn5F6uB5lVodPgsZCA3iyFuRkffI47f8m52/9toRIPA1uEriTS
         dUtTTjR3mky8HOKNd98ga7sbxXWUzi782xnqNaaO8EkW4+JPfjzjOXIgFM/z7sU58P4K
         ObIabiLtSIRrbq6zXIfRwit7lsZhidG3r1FZA0Qh2d24gJEEKCC2Ws6gxF2rQ7P65eDb
         3G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793641040; x=1794245840;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wrj6sTKkJM7jrWxrV5P1DmJmPuQKxsBc3+FZTk/V1J4=;
        b=Lhq+0LPLo4XdlQdMjP2uJA/QqAsN/Xz97EmsiZlGY8tZ4XLtDrQAvWtWBU5dIKuDOj
         0zlzBYp6BItkVFsESAdz10SnIDCQkLBwJ4AD1H4RpAyOX7BBngOPKxtq2cbaD08YwVwA
         wqtVcE08itebVC1afhUNbKaiPAYcdp5SKm7m494BmpPsjlKJw+bFHpZWcx65xWg5Kec0
         f4b4SifcfSfn5bWu/ndeh5txU2bePlVB/g7KR/pE/1XvMl4e/Lh2y9J/p8eBWWER71fR
         3zDFsM5uKim6HHmbM0gpB8Y9lhZ68e5Fs9pHGDUIfr/JkFGZ4qS7MJRoQaa9b4l4ydzz
         o3Xg==
X-Gm-Message-State: AFq9FYI9Q7Ft/ne5HFYLemG2/fFD2tzZooApOROXTFoxxjBFpJqWUnGQ
	UdnAfSBpEHf9OnVk+Uftdv1ZZeEdS4+wHVNQttRg7Gz8361fBqBF8Uug
X-Gm-Gg: AYBFou3OrXLSN4RxinisTIfmEPTIG4vBWDndzuGvNf+wBPJMUKAaAdYetkTQ3KVCtor
	eYz/vRmdTQm+95Sfk/7YB/wtdmwTmPEt7IneU3YXCxNnpab2o53PEaJcFrmPJkmxvxS0B3u9kbt
	6f1x0dQAVLP3S4ivX1dvXfG/gvBs/FpsN5T1fAvGX259DWwwVaQV8Lu2Kh81SZ+gT+mK2d8uxke
	wQ56zAewj8JR6UsBSGj0rpid33ftCfScEFEVVrNr5Yi4ymKivSFNFVOmwQwVkn6O4WbJE/T7taP
	IU9aqsEA8O/kcjTofgGk60Q1VzjTR69drtLeFZER60ezQPfm2c1Fi3XYP2LlfSrNiBnItzImdrn
	d+X2PCBxYcHBP+TK/fN2SFl7B5fJ2iHSzQ89qm47jEsgiX1CB2sItrDeyvaiExxpuUtyuILmrti
	7ZFXSlOMnrdhggqJ2P+PaNFlNoorC9X9ODGnAAZGyeYtpyjgeDZwXJ1PpzTEPQR348dfghBGNix
	c7D946ZQf+CKIPankO1L4EXOLIox8E1q0Doe16gpWwuG2mwaeqvOioPpc+4bw7EbV2wk2orVvRH
	4/60TnfUQrVsscDJzMZ+IdhYWyEITF3SjT1RKIJx7tVPS8py2dubNkj/ebMNTGBqa8HtKVMds2M
	fD/IjWWygKpdOdQ==
X-Received: by 2002:a05:693c:69d5:b0:369:7c:bfce with SMTP id 5a478bee46e88-36a423c6223mr16995824eec.14.1793641040040;
        Mon, 02 Nov 2026 09:37:20 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:98f:6bcd:858b:7a64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm41930021eec.3.2026.11.02.09.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:37:18 -0800 (PST)
Date: Mon, 02 Nov 2026 09:37:17 -0800
Message-ID: <f37327374f65a93439c6cf0c6287a820@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Gideon Heinz <gideonheinz02@gmail.com>
Cc: linux-input@vger.kernel.org,
	jkosina@suse.com,
	bentiss@kernel.org
Subject: Re: HID: logitech-hidpp: G920 FF init fails with -110 since "move FF initialization to .input_configured()"
In-Reply-To: <CAPb1+K1-pirdLGZ1wTUw26G6pvhg7rGP3QZ172ys5DB7rNCf5w@mail.gmail.com>
References: <CAPb1+K1-pirdLGZ1wTUw26G6pvhg7rGP3QZ172ys5DB7rNCf5w@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gideon,

On Mon, Nov 02, 2026 at 02:23:18PM +0100, Gideon Heinz wrote:
> This looks like a regression from commit
> 544315e401727364f7ce3ba771a36f7dc24ba6c4 ("HID:
> logitech-hidpp: move FF initialization to .input_configured()",
> 2026-08-14). It moves g920_get_config()/hidpp_ff_init() from
> hidpp_probe(), where they ran after schedule_work()/flush_work() of the
> connect event, into hidpp_input_configured(), which is called from
> hid_hw_start() before that work runs. That matches the capture: the
> wheel answers the 0x8123 lookup normally, the driver doesn't act on the
> reply and gives up after 3 tries with -ETIMEDOUT. I haven't tested a
> revert. Happy to test patches.

Thank you for the report and the usbmon captures.

The issue is that hidpp_probe() calls hid_device_io_stop() right before
hid_connect(), so incoming HID reports are dropped with -EBUSY while
hidpp_input_configured() runs g920_get_config(). Re-enabling I/O around
g920_get_config() (matching what hid-pidff and hid-haptic do during
hid_connect()) should fix it.

Could you please give the patch below a try and let me know if it
resolves the issue?

Thanks.

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 9646380febac..6b1f55483385 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4098,7 +4098,9 @@ static int hidpp_input_configured(struct hid_device *hdev, struct hid_input *hid
 		if (!list_is_first(&hidinput->list, &hdev->inputs))
 			return 0;
 
+		hid_device_io_start(hdev);
 		ret = g920_get_config(hidpp, &data);
+		hid_device_io_stop(hdev);
 		if (!ret)
 			ret = hidpp_ff_init(hidpp, &data);
 

-- 
Dmitry
