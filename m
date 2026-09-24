Received: from mail-wr2-f42.google.com (mail-wr2-f42.google.com [74.125.225.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065494E5353
	for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286870; cv=none; b=sdeU4xpZH0DtZ4jGYvSXpUgP7MYpaZv6WvSFDLDDJL3KiZZNw7CNbonPEVlA0tnARGU2kdYwYH8NEYOwqoJi9G+s3eQtc8njl5t7A36YxoOVvr3B/m//XiHX5GDk2UH7BS1uERSveA+HPUld3I5fNSoBEM+RRUI2h1kU0e1LhNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286870; c=relaxed/simple;
	bh=K3t+LaWqIf9lBw3vRzbJsWwSHz8qVHJ39IY9rjX9FSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3Denr9nyrpTdfEaVCUNXd2gjxWTozh+guz34yl7gRbrNSFu58tqi2CufDXbtvOswFZZp5futedz6BUwI2TKBRbrlzaDxfRUl0f6wEd6cVxEzySAjo5PrCZfDXCnlIT6W26IVqy1XBqEQ9kk0DEt1H+2Qyn+NjMz6HM+AVdV9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chLh2ToN; arc=none smtp.client-ip=74.125.225.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chLh2ToN"
Received: by mail-wr2-f42.google.com with SMTP id ffacd0b85a97d-482f6351832so137958f8f.3
        for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790286867; x=1790891667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K3t+LaWqIf9lBw3vRzbJsWwSHz8qVHJ39IY9rjX9FSU=;
        b=chLh2ToNPucc1oDYccp4oDB7fQgOE65YxZkJNVxJbIWLcixeyUsRppLAENPd9YZOmr
         BBVvrSLDA8CIb/Gc2tAvWUM1/SojGYw3Df5T9faBEbG+F1MLwlLJKbSJ4hO+erZw0P6g
         QEtfENTqNTehKUyx5r/fACQC84MAYric7dJF5RwbRuvZdns/HFsh5Yr01rwJXmGqUV3/
         eWJATdlaqlEHzvDwxxNkTzMwF6s7B6Ie53eVp3Ef30wyhBtpDT/xD5g1laR5z/xJdBtI
         Z++JUJFxD+IVs0dAt6QTYHt6uGwbY+7ahQ41voMFXiKENlKUexhgvuzVAWlbesOkHrkK
         V3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286867; x=1790891667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K3t+LaWqIf9lBw3vRzbJsWwSHz8qVHJ39IY9rjX9FSU=;
        b=IZK5tb48fihVvMzHkh3fj6AKQU2bHxuxmEY8Vlx46SqQ1TBmEDuXZ0qkXewwQZShJj
         sgwa4EZDCJwSzsPOifMqX/l1bQCtP1BVzlUnUfl2LzENBOZQwJUzQo4uvs/cjovlROE9
         bXOKtgqZZgJ0/q3K/lN0QTgNQ0E33NAMcpexYESZv2oOc/FUOtbeDyH9XF7RUgfDHj4I
         UPiMYwTmpSnIWv5u5mEMCAjllfsCSB21ZY3C+HpQC/F6hDYk6+neyTTo4Tk1cUf89VPN
         bo7+3tpbT180QeGA2eZsTisnS+V+ZEQ/SRaG18LDJNVjIphyQU08jEcQCF1Khy2K6qkP
         4eNg==
X-Forwarded-Encrypted: i=1; AKwUvBzinbm8q0u/HTzoFiRHF/Ts3nE3Ta7H+dZon+4aHHgmsmkWM4IghfnfHya219MNdxl+WA/NBjxal4ZFwQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mLhH9soLGmUWqfSLg3EIHPfe7pzY1zZRIUhkbkcHEwYuUQgQVP
	4EJdlMHQ7z7rhL5VhvqcckL4BPXbXvHCFlhYlWQ3UIG9xHAeXwMPne9S
X-Gm-Gg: AYBFou2xZ81HCy7roK0WM8VVx/LJLB5DwzMh23muDuE+petvuz5nLuxrVKbx1z6BujC
	EbMnSLZEuBvZx1/gdJcIca17GgruUz3G72QcvrY9OYweDHfqbU1lK4xhatWImGpgRKAYVfCgFoX
	4nhc45qISgJEq5lYEHjv/2+TIi+bjxjuWsNOnmmly+/gKO17lwXnuWrB5UAXxpCvJ+TV+Eodrzd
	ndIF4BlPbKcOE7NUlhd/d/arr8r8Wd2W11DQTVosigQR5Vs1XeUTLGUX/bt3vt9T1LYpIhU7HrI
	hDkAEaM4U658EfQSbFW2a5wuKGaD/2guX3EaHyyJVECmSlm7R6cmpTDd+joyf3f6viPC83h/3OI
	IiKDH9xVS8NqNjjrBHqYjXXFm0P76Sb+2tDytOYDytSRoDaBS+rCI6fWvOFLqWwCzW0xUlA7koh
	irCDj4oNBnF9N7aR9soRYk/ZPj5usamvZhCAB+sD3GjNvfICeYFW6lASfIcUKUW2dLBTyrS8QZv
	BMiuAf1zVZQ4QCK8xyLs2PLXkN1piXM1PIrtpV3sZgAGbleYOS+NFkGdexG0rONSYC+OGdb3rIH
	hWefe0hK630+Olb52IeMq13ORlg=
X-Received: by 2002:a5d:64e9:0:b0:487:1575:ebef with SMTP id ffacd0b85a97d-4887176868bmr7025346f8f.47.1790286867087;
        Thu, 24 Sep 2026 14:54:27 -0700 (PDT)
Received: from 1Z10 (mob-176-245-31-160.net.vodafone.it. [176.245.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355d96sm2382024f8f.17.2026.09.24.14.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:54:26 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	linux-kernel@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v7] Input: drv260x: Fix suspend and resume sequencing
Date: Thu, 24 Sep 2026 23:54:24 +0200
Message-ID: <20260924215424.931989-1-mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831150323.2922792-1-mauriziocasciano7@gmail.com>
References: <20260831150323.2922792-1-mauriziocasciano7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry,

This v7 patch has been pending since August 31. It incorporates the prior
resume-failure and teardown feedback, including deferred reinitialization
from open() and unregistering the input device before final work
cancellation. The patch remains unchanged.

Please let me know if any further changes or testing are needed.

With Best Regards,
Maurizio Casciano
