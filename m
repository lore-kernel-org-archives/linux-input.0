Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2E03EB81E
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654499; cv=none; b=habyzQHcuiFSW2PHlWYYEvbWCm9CCFhP4lJWJW5Q/Q0Hr8g3EDoKljrcGpIG0JW4ugEm9y1bnM8MNWWs4H1LBGx1gvE0KFIR5V+AyyEuZWH3kLiqnlNrpg6tyrqKVXgYNu8TzFpyrf4+kaVQmzuHp4r4M88RHiGnmU0v9hE7eWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654499; c=relaxed/simple;
	bh=hahBDvNNK9bmf+J+1mLPm1zpiT7MVEDng4SYTeyjc+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdCYLS2CxrU3KWZvpfuyXCWFyiYlj023nqdH/rOi2DsIYj6vG00Bu0P1/tE3EUFSmK/t+LkkcqX1IfrsGaoPznzMvOnxAwDBfzu7eRPmy41UTgBzSpKtkaBoKX3ZVGucQ1T6zRJJE5Y9oflDSzWamtCXH5GIDsk0DClxOymp/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kncDq+eG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kncDq+eG"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39266382df6so3845017a91.3
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654497; x=1788259297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i94ULdmETnrIASkMFNvJU80RyFfAFs6j38sYTnkUaxU=;
        b=kncDq+eGOi/BAhqmvpqiwbq8HDpd5ko6wSH3DyFlTyIviK+MBbv+vkRqOhEBYE93fC
         y6V/kMDHxHzOhAdJFf0EbEVFCF7m6MD2C3RWCqFTcZsmUQC2EjD5k8R1N6NnnAgyoYJ+
         2M/5jxPdPtWcEVt+F34FUiZcmJwR5KZSamoPLVPSWufPDOxQFFUB3h4PmFyMHSQ4rjmC
         Lrz0hK3cZUQ3Nfo2xwoDTqrkZz8GAHT5w5wUFoB7mP3U6A3xaBazpdBveaxT1Uqd+1ZU
         WYXwYxyGOt9pYiA3yR752da/wfWyRBQFKAQ+uxRgMOYqwzZM7EldkBltMZED5SvS5wOa
         iVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654497; x=1788259297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i94ULdmETnrIASkMFNvJU80RyFfAFs6j38sYTnkUaxU=;
        b=IIsMeWT1EQ4KdThcOY4Ur6I8umZKLiuppB5B9jcgqlcYNHER0IauIficzjL6JxlmlN
         UH04RYeNYMUCFS+Ds4O5+qLNBQ9C0YOmYyk4UXtBCENduGhD3agW6Nx4BO0SurGmZRQR
         OKFMT12n04wx21iduIfvHmG6Qv2rGStxHF3srlcObAlnix1QCCOFEe1UT+AyPAbkHwo9
         eAwFOAalqZf85mOATm5939gJipmwBlzbmHK0SQqpV9RurC/qSRg0QJAeE8VtfWxbdyXu
         i3hiTiLO6xLoCiWyNfwWz5c6vqeT3CI8Wa20ZVOkljnNzfsN8y3wN2PO+6ubi9fkiicE
         YqbQ==
X-Forwarded-Encrypted: i=1; AHgh+RpshLqDeqslEIUNL6/BBPJy4mVg1MerlIUrv3k8WuxX57P9RkYz3TZszIVnfV9aYUE09w+41uxLagC78Q==@vger.kernel.org
X-Gm-Message-State: AFuF++nH60XNr6P/8N9NS5xYksXC7xJi3KV3i5nv4hKYt2OTdfNbLpF3
	PSMWaOOy1Oj17p3vmuFGKZlnLHiM2sm3khf9DG+jUr1/LVTraVFLoKqA
X-Gm-Gg: AR+sD12lbcqHKczKrAhPA9IvdxIfJGIKuq9AHSXGDqsJPqoAtu3g3052WQ8/IWIbL2K
	z4CPXB+K+P1PdDXA+yC/IgS7i/fIf+9E4b6/OFq1sXfP1t99bu6jaZ3k3AAaqBHyoSca590R9uE
	7u9FJztdVBE43azDvb2R7N822mrdO0FiVk9cZnmmo42Oc0FV6nJLVWKx/eUnAOTi5xJ5LNeJ1Gx
	tYL8S/YtMa6sXGOUD0iABSxRfYWc85hvPPcfjsKU9hrRmJoYABmoA4Icztd1dkCRiYG+GveyYvv
	3DSC67co8VrxHYesuZtoKikCrllKW7fcvpGOnhZmEcvV+knU81YEFsElIpvNoQe4EatLGQF6v79
	IzHf5CVPCigxdTuIrlAGUjxHyk8Drd7xomHHdUDzh47z4BirTBy3MU4wSr7YL9Es4OB0twC8X+y
	UUuD5hqr3Ersuwp8YwasaywH10Tx1E+VxQ7ieKK9ZwRlbSwcSyGtvDsgjD4813dScqc2eki2cda
	rpPd+C2m9N68qyAz/CJ+WrwjrgxxUfn7oS8Sy8EOUhC0gdCC8ljrj6zgl6PiZV50x/O1aXCblHc
	oM5kYzUDTVWzZ8+ylBPFLhRX
X-Received: by 2002:a17:90b:3945:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-395c37199b7mr64621605a91.15.1787654497173;
        Tue, 25 Aug 2026 03:41:37 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b82847sm3501552a91.11.2026.08.25.03.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:41:36 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: aduggan@synaptics.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] HID: rmi: fix use-after-free of struct rmi_data via reset_work
Date: Tue, 25 Aug 2026 18:41:31 +0800
Message-ID: <20260825104131.14926-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825034854.63555-1-98lawweijie@gmail.com>
References: <20260825034854.63555-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Superseded by v2:
https://lore.kernel.org/linux-input/20260825103144.12356-1-98lawweijie@gmail.com/

Please use that one instead.  The only difference is the Assisted-by
tags that Documentation/process/coding-assistants.rst asks for -- AI
tools were used in finding and fixing this bug and I should have
acknowledged that in the original posting.  The diff is unchanged.

Please mark this one superseded.

Thanks, and sorry for the noise,
Wei Jie
