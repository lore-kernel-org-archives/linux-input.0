Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585657;
	b=mppDVsicZQHRKt27RdUgIHxKig5RNhslh9iMF0JNQvWeuQuHtXqNpfs3ZiZQ/bxjJ+tl
	 ixqe46cmnRzaOyF5DaSLrY4ky3KwRRElOJ/nL5gwq2GmmszZ9Id7eC7NmXx7k516np21q
	 opuhr9n7vN/lO4p0LNKC0UGJYOg71V7rCVa+hnz7Er+CNvKcN33VllHjsKnCfAPffrQwR
	 RmBcQdM0QdDLqBBh2P7/p7p+rPxdmrfAc4QQJ1QJygl9ZVRuAxXOXq8D4CjoOePLmcXwU
	 +QkwbCXc40LcTiP/11xtYiWeNYRzafZ0KLweu6GBwTHYPn0sZ/LxEstRy1+mENNKiOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=76hK192hwNNcxMcbm0UzywzzRTcZcsnY/gd0BW0R8wc=;
	b=rJfKVM3QjonbyHMxr9NS70YpXgSnC3GxTKIFi2ZXLiBHHq4KhHbgC3/exaoJgJuOyEup
	 r3MjMhRbGyi4lfK0nt9HiH8nhJbZyDD/k3o1cMyRMaDpYQxTgVVyG82CvVfjzY5y4atHP
	 KONVL1aiaMUt6+HVO9hGh4UM25jezmbEJy03vnHxw9D3uwsxORnMP1KCj4hDwbAhGnvSc
	 T2zsLUh/jpGY6zzc0YCdZ3c7meKJ93Li2GZEt+nYMvF+UglVRplpVOIb1gGn3o/ZiJivD
	 lEQgVo4W2iYz8UWilGIOCU/tnaU5BD/MNfPwuynOGwfDRhJJ68KWfjvtT8XbOG1QomQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FNkjY8c5;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B71606B5ED
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 16:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93B71606B5ED
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FNkjY8c5
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36f8cdd30beso2874016eec.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794585656; x=1795190456; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=76hK192hwNNcxMcbm0UzywzzRTcZcsnY/gd0BW0R8wc=;
        b=FNkjY8c5qVoxECoy9cH5IqZVYrIDNUHHh+EI386wFkJOvTo8i7gMp6DoGZKImma+8a
         4xHxER0iCZjoiQFZLsWK4msE8tgrpKQPrqPc6h5XkCBmfK6NvlQAVvavnjIsy2WPIV0y
         +WHgWAkOUdJF4X++yHTft5Pypxk7CHTT8+Yba/4SSsBXJvqU6phdQhBIJd/g7ExMEg+i
         OgowQyD9OfSJli99pOCQoJOvLIA9W5SKPuZlnDX2Lne8OmuFhhaKvg7/hb9DVyFoBORa
         Vpqi7lWnfhJWev1FfnVNfJMP8Dk97aPGObaWfT3OgXLc5CuZzKmIhpszV2ildSXt3Nw5
         jdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585656; x=1795190456;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=76hK192hwNNcxMcbm0UzywzzRTcZcsnY/gd0BW0R8wc=;
        b=zRSkQp4jNZnJEF+YlNl/3W8xb+Do+Al5H00FqfoTZB5HiURIsDnaSPf88ry0DXUIqU
         HGkoU4ctkwuOjtrFblvLJ0DlTjMIdSe4vHeTPBJxeWdHBHvb3AJSLtDpx5CgWP0rGiYP
         vqfLAHNcs/OAqirQS7yno+NNpCveEBaQP8HpMbs1e2RDxmebZjUpJWnm4RpQZzDMSQN/
         wWVC2mSe1UqLppTGrVvve5dtP5lZmgLAoyywphlAoFQxlYRz2RTL36cfFNv46nKAlFsf
         uYPTfWD96aIKHB3pGYk+wHdwus6CsE0rR98tLWi+fAL3sSPkRTmAajXpTNyc9C4ftBqf
         NkMQ==
X-Forwarded-Encrypted: i=1; AL+hErFfAW11rwtx8qMGFgX7q5zrCS2MIfnvvshD/IQ9Z/PkAlSBOh5pxZUBimrJHVZk0XVLTGOyAmG3cSpPPA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/kBYcXQl0Qtzr+KRrGDMptwWQ0ir4M7WE3BVMmOoTSLgNlak7P
	dHUerbZrV0AtpT5fWhPAtFKyGjL6dqZhiNNQUVE+hMOV95OKHgJZmb0d
X-Gm-Gg: AYBFou3axDCrsOHEWLsk12vZruR37fggb2XfM7rPmnyTEw8/K4XWwH4iBF5wkpdRsY6
	1KDct3A3bTXKBS5Omml1nG0cDCBL028UifIoA/bqAV1kwQr6k1V2ExOfdJjsZmUeP8B6sfhDDLb
	xpDs9agsm6mDlSO0AksXgvw01kUAFyHPeysWkzbk6u7PbmuD2RtUmR1KtZ5+oC5QdUcFui42IUD
	EvZ6zBzik1ew8fXoE3XTtPH9WO6WdAmuU4l014+ce3JfM/ICX2v2s8O7kobaA7ZqmQFegJb3hqb
	IZ59jRRXPWcrqe8cWqveKFbfPjXkm74i89xDowgLP1MkHHe+fjf4+KIJplo0mUeT+qnCa1rjL+a
	QZv7pYjbJJMg1uIs68MtS2yz/ONGDejSxtOjfpSshx8AEkunstW3Q3mZpE/5/AdHhuyRGTyqNNk
	/T9aCsh1FRmupGT8BWGzo9u9kCgU6MnGUTTG/TWX5k8dTA6D+j06s0/A9thJgkSQhk5Mvsozi7O
	CkO1upTRPmmO5WGlQOp3fOc8FrAFMDEPsZr75SxgXnoqLyKoDDCR6Y0SDZ/3z+DBbCwLlnruAaB
	quZtaNsrDTEY6oJbnF1/xncf1Q5OKXmvTQIraQlMnGlTFfZKndtv7WFeO6yRXTXxdUK09Q==
X-Received: by 2002:a05:693c:8312:b0:374:ea35:9069 with SMTP id 5a478bee46e88-379681cdd7amr2329847eec.39.1794585655380;
        Fri, 13 Nov 2026 08:00:55 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379508762a5sm8587820eec.0.2026.11.13.08.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:00:54 -0800 (PST)
Date: Fri, 13 Nov 2026 08:00:53 -0800
Message-ID: <9594e8428a3fbc94e515c9dad2268009@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Vishal Tyagi <vishalxtyagi.oss@gmail.com>
Cc: Markus Rathgeb <maggu2810@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "Input: synaptics - enable SMBus for HP Elitebook 850 G1"
In-Reply-To: <179399405216.85438.8327280593401118083@gmail.com>
References: <179399405216.85438.8327280593401118083@gmail.com>
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

Hi Vishal,

On Sat, Nov 07, 2026 at 01:10:52AM +0530, Vishal Tyagi wrote:
> Commit f04f03d3e99b ("Input: synaptics - enable SMBus for HP Elitebook 850 G1")
> added PNP ID "SYN3003" to smbus_pnp_ids[] to enable SMBus/InterTouch mode.
>
> However, on Haswell-generation HP EliteBooks sharing this touchpad controller
> (including HP EliteBook 840 G1 and HP EliteBook 850 G1), the touchpad fails
> to resume after ACPI S3 suspend:
>
>   rmi4_smbus 0-002c: failed to get SMBus version number!
>   rmi4_f01 rmi4-00.fn01: Resume failed with code -6.
>   rmi4_physical: Failed to resume rmi4-00: -6

Could you please try the patch recently posted by Markus Rathgeb (CCed)
that retries reading the SMBus version on -ENXIO during resume, and see
if it resolves the S3 resume issue on your EliteBook without reverting
SMBus support:

https://lore.kernel.org/linux-input/20261105204953.69572-1-maggu2810@mailbox.org/

Thanks.

-- 
Dmitry
