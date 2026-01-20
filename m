Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB93F075D
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938996; cv=none; b=BzojJBuYnVbSbZZY/pjP8giFtdkmy8vEJB9pNU5/J2khtOamUajqrfZNowxAyZHsClTkvFXMBsGON2HHPlYwL6a44Q3I0yNWVngELQ2NfsnE4mAJFOH77jEgYReN/TmcsyYYy33e8iL2zUY0SO6F8ueBFcTnA/qLhRxeq+3nIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938996; c=relaxed/simple;
	bh=dpRYr3skIgV0rzJn+6D/Wwyl8T3WJJeqflIDq7vz970=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNQvLhNHQDw9tp4hWYBmrmytqJGECmqu5BLMSPnsx2ieKuPwVXszYvDY3msOLTxaMHl+Dgjxlqx/tRax1nSco/oqnguw8uPYCabZh0PKiKgqv+4aT3lXDDq0xmKggP6ljkaDGE38Gxrb9DKgCLMq1bPY2pkZI4p4raknlQL8yww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilTP+W8u; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilTP+W8u"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12336c0a8b6so12128323c88.1
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768938993; x=1769543793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPDgUMFRl+w+AbB4KcmndfGR0As68bgylKNbbH3AGMk=;
        b=ilTP+W8u0C7h7XBeoah7AsJ9JL095ZDFwxa6je9YceSe5kL434AEa3e23rZIbJCd2e
         jnO4xLKmsw5RyE29tSBo1CYXW/XhUGjPEV8BMF3noJo9ZL8fHVkWA5vnGSaSQLiOet2G
         u33Z96XEok44vp/L8jcalhxIbLF2VdgdGVnEmHJyBf+WvA6eY40iDArMrDCHTCvuYbGV
         R2IRMW4ie8d0lDUcYo3zWHSLjXKq85+4R/INtdkQm9SrWFC2O2lwXCSL+pV6WY7K/Y4J
         v/prpxeGXBy2mhWGLzQMm/WfVUt37+/etLvLAhGEDEyKKhHhl6i31LdTJJSmRTJrCn8K
         b7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768938993; x=1769543793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPDgUMFRl+w+AbB4KcmndfGR0As68bgylKNbbH3AGMk=;
        b=YE97lrgcIyYdNdjdXo4vKYnMFNkfpLH2nKxKwjAAHyYJZoTEo2XAR0x4peRsGolBPV
         6g2AsExXeIWUWGG4sFr/TqYzUuASUAJJeGti2JKukdqUJhP+NyXHSjPmW1KnKM92PhlO
         TLI1A8NJO4eYlQZ1fjIetoCRux94S12mgI1S3j1RHpLDx7VYd7OIxw3hbvWViYQuLVtY
         OdmvAdBIDMf9JtJT3qzHfYDL6lTbKdb3F7BTBrTqCczPsmA8TVg/CPfNgoyVqRYpdhMr
         JgYO3l+JjwbNpAFwkl13N5tSNgRtn9KbG+YNPucviVCAMstwP2XslCC3gBHMRiMwPeBG
         Sbrg==
X-Forwarded-Encrypted: i=1; AJvYcCUH0agZE4tJd+1dxyv/u+f2Wvm20DcpyNjvdge5MbPEhwyCL5Gw+PyGYtE2cqWyup6k0EbPHqo1xbP0dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5G2B7qKv89etU4P56royLS7lv1CHhjecScfIKMJvnD4u2jgLD
	ZmENtPU7mFk5c6Zgu5OPCkgr0RUiAy+KUknikwGsSbP1kyyyiYiG5wv2
X-Gm-Gg: AY/fxX6Vp21R6kcwBKgyVaFi5l/8Rzr9I55hT5ZNu7aDO2AfMPjOzNvll6GX6B7C4S7
	PqD9HyWkfVQaP3FfHPtEaWuePd7AcOqha/L52PoMWiw6c4arNQhYhLXwcoIKnko4Zq/7k/lp3le
	Zx5NHgvcLOkx6SNE90gp7F/CciKb5cQV+IVI3TSRig7eXPpJDmq+3KBHejM1Hi0rJWX1GNK14i6
	kItGIXmAdLBvttcweqk9lxwhA4CQxHbMybPSbLuIhP0brtdYcG9OJle4T2rHB3Lx/bTIQANqgqW
	2BIqb83JPOOtcE3vYJEQL0J3MRG6mujzygKyoNIfCMxXZZzgr9q6dAqi9jlS09sBWVihRZ5qRtq
	3+fLo0JgpOrvimjyzR5ZflML9ydMUONs/p31HqTpkSMtQkhNsx4yWpuPzUKOdbbZNvpH5Va6bIl
	v+NQET6jnvksyLwZvDcXnfcpGWUNBAQUQFgr4p/QPTXOt3p1KuOH4r
X-Received: by 2002:a05:7022:608b:b0:11e:3e9:3e8a with SMTP id a92af1059eb24-1244a7910d8mr14869120c88.49.1768938993269;
        Tue, 20 Jan 2026 11:56:33 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d631:e554:f0bd:4106])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad740c5sm23388705c88.8.2026.01.20.11.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:56:32 -0800 (PST)
Date: Tue, 20 Jan 2026 11:56:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, sre@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v4 3/6] dt-bindings: input:
 google,goldfish-events-keypad: Convert to DT schema
Message-ID: <nab4yksjgk7jbofm5fkrafuz5c3dmi2oocdzgoscfj6ua7zwfh@olnrxt7sa3qp>
References: <20260113092602.3197681-1-visitorckw@gmail.com>
 <20260113092602.3197681-4-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113092602.3197681-4-visitorckw@gmail.com>

On Tue, Jan 13, 2026 at 09:25:59AM +0000, Kuan-Wei Chiu wrote:
> Convert the Android Goldfish Events Keypad binding to DT schema format.
> Move the file to the input directory to match the subsystem.
> Update the example node name to 'keypad' to comply with generic node
> naming standards.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Applied, thank you.

-- 
Dmitry
