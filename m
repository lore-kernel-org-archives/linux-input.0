Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E920F389111
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 03:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784951768; cv=none; b=Vc7FOBzVZCLnWhvZnLH7BUIio37DThJTcsksrzCV1f5zfuhgXCsMBASHnp2gyDtM8R7NHT+aMBChYSRXn8Map3tiG0BEFIniXphUi/k3ONGWdqhFiXelBad4DNy8Y+ZCcX042UNmHl8QwxPk517+29vcRT79/DnR/EkRnTJEyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784951768; c=relaxed/simple;
	bh=AQOGbsaqY5CNDvfdu5iKS89QbveqN0mDmOoGk5FQDwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fStprZZ+1o7F0EJQu3/rdeJM93gmF/xV5j3OvxWFGfBEd2jExzjpttHywQnRb4kiOzXQ2ghyBXZzL4ovVyxJrSKAtvbNrdBj2loPGFJbnQSSCuw/iKvm7ITyOQh7USJLNWx+/2KuRI8g8YgMCZONDslzUCp6mZZQL8+q592Z66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUfDKr6j; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUfDKr6j"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc97653887so13299195ad.1
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784951766; x=1785556566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PSfNV1C0CZLC5Gyeq9chzpvr4Scx9eEK9usvYx4E4h8=;
        b=GUfDKr6jKsn+Od5jKs5k+VuoQLHQ/DNaZnrsvOpLl7O6bTA5WF2/1bupWSdc0U0gA+
         ciKfRRCTAwvUwtg6PVzUl+KOuBkcu0014hsg3zqcIlEZt44xQx/ItYT7z14+S+JYBUD9
         NU/W+LtjLf1pfLqwSvimfjg9Bc205/H62QaCbFMQ4xIvFPypHAp7qee+2vqRAUYAEYjC
         zFbhxIBfytdH6NbWGAUnCRz4bEN5jsUPJX7bj1B8JFOz8XBUfB7VSMP33d8B9/ghzKTa
         LE/qj+6Z/OXBmAbCR3iBzkDKjPGZ/NvyPafzi5GkSVgkS63yUDENItd01wTB3/Hnq2RV
         DMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784951766; x=1785556566;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PSfNV1C0CZLC5Gyeq9chzpvr4Scx9eEK9usvYx4E4h8=;
        b=aSmaCLBb6/QdViGfEGlLE2qKNtUqL38U8Fe0YZcJSmgGSwc9GDlPn2fSpFRFJJMQK6
         ktd4A1mqnDe+sO0I0YUl8JRGIE5ior3HF9JSGCY7ES8TDI34bJH5ZmqCusv4CQOHfDHX
         estx+z+wi+GwifJ0of+kfJB8Wjo6qL6RhFI7YOSqv5MXzXJy4/6KfCox9uRr0DqxJgOi
         2QYytgswLxBBzz7H+dUbpY9zmrpBS7cwW/vdDT2vL0kdEFIc0+XEMFk97zk4aHpcT9XR
         kPyOe95ZxMFMZK8Oa+8gY3RWuo/yUNnk43mm72b+jEYdA/83CT0JIn00qQOy9P3tqOVY
         XgUw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6tDTxlOJM8mydIneoyROG3RhQbATQv1LGqP0N/Vc5UjGFC+dhgq2CDa3dnjf8uPaE3O5m77v4zC5WUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qlZnSxzMrq9AdT6FEqPbgfjmA+OQHsS56VmAu8A1P2CfMxwm
	rIzGYREEzB6LkFY3Mh1/0+UYcqKSD57cmAxZc0wA0+0m+S4aGq6cUCE3
X-Gm-Gg: AR+sD10f8If07M11bZssKO8eQ76SwoQFokz7bhdWwZFVZBZwt3HL12OgJnRtasYq0pZ
	6exGDM5Jwg2BSJ1m8g3k/xwUAY4QrJt459UfuxKxlZuB8QBHvCSE4vzTR19aNUfVsBjU5AhaDb3
	+B5fniusMqabo+Mlwp1uc1ra/A8xQ4/ZVRVDGiAoSmM8VU35qUPs5syZL8VxSQ2zMnQuW52UKLw
	iVjt1zBnrKAJYwja1Sg3KG8It/mj2tFPZlDlpJyEZzegkS9L453+NpnnVDsp+bML6xOlH5TIbwO
	iDU7olEan72ZVvO3greKdlqv8WC5jiETYQmcXcFzOZNbyYVYdLzcxUOQGVXIJPF3O/tsqaXbVrE
	7k/836SbmWLVBCaOKSbK2Q76Hpa6BWDKQcuRVSqoWvIoc28JRGAIiJRlZpwtejzGX1GFJCPf81P
	WJT0A51XL31cBveRTNszXt61kLc+VKXOqO+YqBozpUwDyv5ft8GusJDw==
X-Received: by 2002:a17:902:ef0a:b0:2c9:feea:4e4c with SMTP id d9443c01a7336-2cfde7b3945mr10605345ad.15.1784951766109;
        Fri, 24 Jul 2026 20:56:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5a67f3sm5158323eec.29.2026.07.24.20.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 20:56:05 -0700 (PDT)
Date: Fri, 24 Jul 2026 20:56:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Bryam Vargas <hexlabsecurity@proton.me>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: iforce - validate input packet lengths
Message-ID: <amQzyVU2CExWfnm5@google.com>
References: <20260720115018.75045-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720115018.75045-1-pengpeng@iscas.ac.cn>

On Mon, Jul 20, 2026 at 07:50:18PM +0800, Pengpeng Hou wrote:
> iforce_process_packet() reads fixed fields from joystick, wheel and status
> packets without first checking their lengths. In particular, the shared
> hats-and-buttons helper unconditionally reads data[6]. The status tail is
> a sequence of 16-bit effect addresses, but an incomplete final address is
> also consumed. A successful zero-length USB URB additionally reads the
> packet ID before the common parser is called.
> 
> Reject the zero-length USB transfer, require the seven-byte joystick and
> wheel prefixes and the two-byte status prefix, and consume only complete
> status-tail addresses.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Applied, thank you.

-- 
Dmitry
