Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209034;
	b=Pfr8RiAbf7eglaU0qX5NtPPCGRTLPX0eNxJZjeScWnfv5mxxoBbXUUmhrbVCDO7ou/SD
	 RjyhsAS1Knm8jw3upUtpzzpF1p1D7CnOu8vkzRYlxHxMOOw/w9VKrbY0R3QQ6VBrRGvbl
	 bl2b8E+cPMrdqlkKhEJbHf+aCUj4AA5YMH8QmhESZ8ocNd70y8U0ph6OH3XS0ulmNszcX
	 NtcNXONxhX7VnzIY9sFf77M+659AmsF0vIQC9vXA4Uk207a1jQ4VQEy7+L2a1Lxl4OT/s
	 ZaGS7rpTsGGz6ITZUMuT8FTwQ27xOS120RJ4BowH0kcIx9zstuZFghDvsA75b5FwmRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kF5gL+pAF0me5uE64gOZsyv6XMkas8uXTYMZ5GaQlLE=;
	b=4WQj/MI4ARTgns6FRaA2uSlsflOlZKazxfka8AhQq8e0Ozg1t4iqTIyzjRnH9Tz4xghN
	 VNj+ZhZAwQjrHoPWqGX+k3NKNJ96ra6l3B4OHQ+CPKLQkh9BjPRM6vflMXi2WNyTyK1Lc
	 S3cAKspYY3RJC5Sy9CdpgkEdW8GT2x2PJrWqLokuLFEwB/igPCEv9DXF9HTa1DEhoGMGE
	 2lorD8RYRK8F3AAqxeV2SIcK9e1iXte3O4bSIjsx0BnJ7XF42JmrrRRx7dHDlxtfDVAdD
	 Jcx3FARblvAVWYn4kYyDom1eVspysfvqN9Y2Nh/MOgR36fcTJBsDyNAy7M84PyDtPHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="U4cNbM/M";
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2258606A6B2
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 21:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2258606A6B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U4cNbM/M
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-94960131b30so143800985a.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 13:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795209033; x=1795813833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kF5gL+pAF0me5uE64gOZsyv6XMkas8uXTYMZ5GaQlLE=;
        b=U4cNbM/MCS1lqHzP4af3zTfV4p+fiI+7uZEwnKoN/qMzmz7VOQVArRanP/RyEY1Oyk
         Rm6dl7Qe1OntVJ1D17Fy3aIQqySH+IDannN89qZS9knoYQpazFYemYKxVfUdV7OGqD1r
         IBcbO2cztn8tvXiWAZfjXBB1BKsIfCmQFGf5RecXlcIkUY/tBZ3ibdMkDMCkXkVtfNtc
         vGloANDX+832KFE9jEESVjI/fC/aZrAwSWA8ttogdsVI3RdVIpJpJUT6dM1q4LZ8yVPQ
         Ibs0TkXCyxFFbenZfUmSEsTJrerS7BTxA8w8Pqaz6cMw2Wk9mOwM5PatArxHZaBZpae+
         MXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795209033; x=1795813833;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kF5gL+pAF0me5uE64gOZsyv6XMkas8uXTYMZ5GaQlLE=;
        b=fbcLp1a7MTPer1UumkvTk8Ivfo2hxhZ48HqYzCbnV6k0JDKmQffahher1DXptPqEjW
         uqnsXPzF9aiCt5wquonOtz+3zfSLIE6fsg2C30DHkKed5fTLg2z+5OYMgNU2pbbG6SPY
         9lYtLno1YSJlylrD9pwLHTi0J7cYOugRX/tdoTF83troXYR8h2HNpQg299jTuBQyvoMh
         VZ+L3kGUTfTsSBd6S9GDW3iGVnjYyg1qgWkTw6rStz0Ozt7LVNRcBw0bD26gemYtvAya
         6BUc2yE6zZHuOO1vbgQ4dhuN/3dwcsEixYgUV2ruTQdg9YZx5JFgLm9kxpcLhNxntw8q
         vQBg==
X-Forwarded-Encrypted: i=1; AL+hErHK7fE1WVxmbb8z4oXleU80cguVQkA7PtKO9Ge5PO5o5X48whpGG36a51feahW2y7+VLfhwhHNCp6r9zg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9nb5OVWWhnGIdpIBVpwu2Na2yTbZCLecpVtGfuz/MItq0+MEbZ
	UkwCOFWkQrSPpImqAfJeSwMSkoGgk/IOOxL9S7P7/mTs6mQybzZGmuRRn2O3X00mU9w=
X-Gm-Gg: AYBFou2Tu541jq+OiRHTXt2bnVuqSWLiCbmouovEJ0ul8NombX2oGPC+fKEZ6A/0dFm
	5xWcqvteaBLehbZujSoqawIm5h5BKGVklgRwr0Q5f2dFlohozRO52ram+j2+VEzD3chc4Di11Qk
	XGnz91CyL3C/clTRIlR7Zo6Mplrby/rAPsdc5GB1yYwSjdfbDS+AdDCD06LRE7R8p/LJ1rvw7es
	XQOyVll4s0no6vFzREQ8h89A9PLxh3YA4r5s7c6xOcXctA95igcg7bsyPtKX1X48OJPJ8kka1L5
	IhfpMVHpXBs14qFfFfPXPXZCSqPylnYb09s0nmZUHV0pymQFNXkoDNRWR1eLDLHvfCSQDee7eCt
	uCV2z9Sf90iZWse5rdGAdsEbAmzTqwl2Fi7Rca/y8zuvdgujIUmJTSazB4FTNZEiQ5l0jC/Jsjp
	zxT/fYeDzqimB5jOtbujnRwaqRGqncZVzmyp8C8KuPTYTao8PMdXGdPcO2MUu6wHAIlF25s4N3F
	gqixvoQatNEHxFqiCZhOvmm5Uba+rebW3P6CgERMrgKBEXvpRmmqvFa05rCet+IxFAx6pWAW0sL
	v/sgqYgbx5zmxT0f2QWLNdTea5A2ldNSfK/9bOTeYVsuWUnPfjrXTv0pClbZv5QfJ0FOcrBip8u
	MVRzB5+BDF2HvmZG4xmzul51aBfRrfS8Eiu3+2wlXthQDHzBitiQsxLVf4/cGOuJdHIQXYzSyX8
	HF2aknGFnbbSrAGvSyIeEYI3d95aFDiramo3VhC+rkaA==
X-Received: by 2002:a05:701b:2704:b0:1b5:4f6d:8277 with SMTP id a92af1059eb24-1b5568e78b1mr3904504c88.26.1795208605472;
        Fri, 20 Nov 2026 13:03:25 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm8865172c88.2.2026.11.20.13.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 13:03:24 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Zheng Shuhao <viennaoffh@gmail.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
Date: Sat, 21 Nov 2026 02:33:16 +0530
Message-ID: <20261120210317.184756-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120121256.35339-1-ayaanmirzabaig85@gmail.com>
References: <20261120121256.35339-1-ayaanmirzabaig85@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Nov 20, 2026 at 05:42:56PM +0530, Ayaan Mirza Baig wrote:
> Changes in v2:
>  - Pass 'data' instead of NUL to device_for_each_child() so
>    sensor_hub_finalize_pending_fn() does not dereference a NULL sd pointer.

...

>  	device_for_each_child(&hdev->dev, NULL,
>  			      sensor_hub_finalize_pending_fn);

This line is still unchanged context in v2, so NULL is still passed and
the callback still does spin_lock_irqsave(&sd->lock, flags) on a NULL
sd. The diffstat (4 insertions, 3 deletions) matches that: the only
removed lines are the lock/unlock pair and the flags variable. Perhaps
the change didn't make it into the commit before git format-patch?

Separately, Zheng Shuhao posted a fix for the same syzbot report:

  https://lore.kernel.org/all/20261120135005.566-1-viennaoffh@gmail.com/

It passes the hub data to the callback and also skips children without
platform_data (e.g. the HID battery power_supply child with
CONFIG_HID_BATTERY_STRENGTH=y), which would otherwise still be
dereferenced in sensor_hub_finalize_pending_fn(). It might be worth
agreeing between you which version goes forward.

Thanks,
Arnav
