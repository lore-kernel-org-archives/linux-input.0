Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125833D6FC
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 05:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785907312; cv=none; b=hxT7hr+aQYjQxbi+OTYqWo/SbmiuwOuv348B+ePBSPgd0jUVerFUvKmoXJpMqYdk683qFBEG0CX1oZd9xDrVaWyTga5AX+VqETyS+A+Rg5yrtJuAwypAg2CzrpS68lUDkBgpfvMb51LHXkQoxzSxFXHhI3v+qv03sc1PrOV/OUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785907312; c=relaxed/simple;
	bh=5BLN84UWE5aL8KC1TYqhaAbXFpJ/PAqioCsYhC1X1W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t84aI+WrcoSRKUeVH6n9AjVdXHpdtKjwA/cSmEu2eaIoZc3Ga1MHCTPNQPgGCYtvwPnvmG19OS3IgyuUme4nc9zPXS50I67ywjteT4x1e8dAM3dNj12085UgqKwLrNAUE1Fn1O0uO5N5YksdPeRwsxsiZu5vKeldD1VcH+fuwrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQjcMoUu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQjcMoUu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d049069377so6070065ad.0
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 22:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785907311; x=1786512111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i+SgxE3ywvb4IGbVXZDenqphK+NGLI4pTkX6+69jjI4=;
        b=eQjcMoUu6Gvpw3aPUaZ7wem7oApGlpwev81IBut9BGbx2VImjl0mVUZaWXuX96JbIZ
         TZ3DQZ3BUAlfGl6sHD+qUwHCjk2lxFhoa7M1c29SBXYPIDStQF30s4DrbRwfSRiuBHg1
         cYtS6dpiGnj1AID3q6mHR+O5J2zPqNgc3pDCeHflUf1VTfzCNZkmJxmfo7PEF+81OfBe
         TF6ZLC3BWLzcLOSq3VU3iiOEeI0vEZN8hUHGlbnzN0FEt9sn/jF/arvOu0rdJpdvExSv
         CxG3fxB4HnzXy3yE6XPnF7kHKW4eQ/ealNFXd3XXXNSOOpcVwSBGKr9t/jIPz6OVsNE+
         Nfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785907311; x=1786512111;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+SgxE3ywvb4IGbVXZDenqphK+NGLI4pTkX6+69jjI4=;
        b=rvcVB5IXXbKyikSWwKCL8ef+pIAenQo4cFiDKyipqHJnyEaZK7ZZc960w8WQdfRi57
         AMkWEMf0ww2QaHtubxY5EzVNfVB9e66NFIgpSRxtHDISDHhd4ZqWrrYSSWcaN8NiaCc1
         ywcQdZMsFrG0FDr9+jBQWSELjEdurOkeenzXOK3M0qk4PurXQk+YXIA5HuD9dXf8CpoB
         zaW7gvSgadJKZ4rlG2h9i+o5BALi2MDeGdMQ0kkaeSHlz/1LTHQj7rewj51KJjg17UqQ
         6j3heipnIG5UBWcniLsEiJCrASz5Djzg/F9qDzSVuGszsw4IXcJlX9AX7QglwEA+Cahr
         uIUg==
X-Gm-Message-State: AOJu0Yxcq3xAnO6NufeLCq73IgiCfqxosRzjMQYMEjGj2tunrL0IMVI1
	NaxYrnE1lzv4JK1n9U5Lk4iudYZOm1K80uG7wqevWE9IGDd/C8yAPLR0
X-Gm-Gg: AR+sD135kfA8hvAysRolyHyplHZmsNmasXocpa9qOJaHx30F7lEVH95uZvtIF1GHEJc
	4v2aFKaiJ7O1PAdc2CbATjTLyC/Qyu/MFHcZA+w1vyR4vUg9IEmeSicq7mzb3dFnX0lqS62nG8r
	HDj1MVj6bDv9evwtvI0adwMIEEQ6Kn9yfQYYu7ZarfLwPQp+AmaHMAIDtTQs5rULgzl0pO7zgp5
	Lxa5tuzMyhb6F0NFiP7YSdxT9Ai3yXL0Fq0qciqOCTa0FiCwypi3YImwiKDu15SY6dx14kYEz9L
	uO9rrA9ckZ3z9nrMKrqtJoBBhVEuMjI0V/Tzw7TYjFXnfhVQuYWbjktiwt/TbmuHU0ImxDODBgS
	ySCHy+UQKmq31is1fGlI/UbvHt5M+rF7cpR+9Ja0gI2rbNgvtDeHfTOphqoh9/Mgur6+4tRTKWM
	VmDvs0IQmKIxKSTHpTnDzhBjEUIc76QTTh86WMmDHXoHNtBF4uQh5UvSmr6uRWsHN4fGFPvYzUp
	R0F+9+5VQoZe+9EEUoa/PpN+MWEPg==
X-Received: by 2002:a17:902:e545:b0:2ca:bf8e:35fe with SMTP id d9443c01a7336-2d0ca780473mr43369225ad.16.1785907310604;
        Tue, 04 Aug 2026 22:21:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bf3a:ac93:79c4:84fd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586447d52sm10850397eec.12.2026.08.04.22.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:21:50 -0700 (PDT)
Date: Tue, 4 Aug 2026 22:21:47 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: david@ixit.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: rmi4 - honor touchscreen-{x,y}-mm
Message-ID: <anLH8cYpnvN_DYZu@google.com>
References: <20260731-respect-x-y-mm-v1-0-3e85a4bec745@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-respect-x-y-mm-v1-0-3e85a4bec745@ixit.cz>

Hi David,

On Fri, Jul 31, 2026 at 08:13:40PM +0200, David Heidelberg via B4 Relay wrote:
> This series ensures, that when invalid value is detected or mismatch
> between value defined in the device-tree and the read from the
> touchscreen is observed, the user is notified and zero is ignored.

This seems very complicated. If board maker specifies these parameters,
they probably want to use them instead of what the firmware reports. So
wouldn't it be simpler to not try to match and report differences but
rather skip querying hardware and use device properties if they are
specified?

Thanks.

-- 
Dmitry
