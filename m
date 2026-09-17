Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7C48488B
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657978; cv=none; b=QPisYhPDbR2qztur2hCbT/g6qTa5R3jWBalV+dZjBBc0zOyWKACl84TDV9ggXFEQKYuHJo4/YXo674hNddMIiYRBxSbk7J5xbBJTmzILSvrp/3gTjCuHlhhpcCK0tXIP9x1crm/f5VEFad9B8PBHzsWfW0rBb3NYyNnCxYGUMR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657978; c=relaxed/simple;
	bh=CbunwsL8JbHZjO8IM65+jSsP1jsU9SGK5nn8nXpsnhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHjCRikmLE30DEN7qXBNz61px05ciw++t8+dpRT8pzHyyPkywaT4uoWf8qI3X+3tpEI3bnK77LgTHpoFci1sz/B4ZqY4u7M6VR6JZuXRX8qGcNSXvx1BrMHVygc1QR3NfVQoR7Kj6Gd+IORVUPKgUK7J5L+4od3OLqTxUwSGal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBxp71sC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBxp71sC"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-395cf2535acso967796a91.1
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789657962; x=1790262762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WgO5G/ZcSEJPK2YjMAgrvF67kRqPqqguP0ntcBM5S9w=;
        b=LBxp71sCtwg/qMyTiTQjc2/3DHZHqKjlOFpphNN4oFo9CBqN28bopvWFeCnkuk0Jv+
         0afo460+y04GE9fiHCmQYkb1m2T/CX7HeAYWasghJLUNB4uMOHuK+nw+3FvU2SAERM1l
         39BZdjS1jCQcACWEkGkZQCMBf7owZim6Cq6B7dC5rmoN2qyY0vQTYvNUcBhnuHBQwGwY
         JbnOY1MDu6v4CG8bWOIDWt4kpOETbS6LDEWZxWym3Cde723tIAQKYDyPQl3dCgiRDnya
         fQlhfBJxNJPUvybMM1TXgeusNwiah8BkE/kPr6FYC2VWhM3+cWIxnnk/lTN5MGODB7PP
         UJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789657962; x=1790262762;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WgO5G/ZcSEJPK2YjMAgrvF67kRqPqqguP0ntcBM5S9w=;
        b=U3oz7FYnHQNX2eNrqZ2BUbPUA9ydigvZfCDTwHYnej4cItBwY5jOjRlUPeMv7qBJMr
         Oc3lMRAEdDqQQ3eRAuWAoFxanqiQnpGUrAnZI6s++K2Auy38EFYCsUGVmpRdTI5817nR
         QiZSctJw/55mkUH7/pnjsZ/kBW7i0c9BX6h5Vy2wafHTOoU+cGQNi7ke5N8tfumfrsK9
         1eLNO4pHLEr98OcQARh/mZH4+QlbGMtqe9rjOxOH1EmkU5f372inEfV3lBc2U20NeZhD
         ppfxNFrYgodWpQXiyTLR8N4aANC9afjVhNEfaLzYMmloT4nDTIR5Z9xj0vXXcaOhsNRR
         YdrA==
X-Gm-Message-State: AFuF++mHaZfrjDDKJ/7kkjR2QG2HzRc3l6mlbWDJYO0929LXbNKaPtwq
	tj459SKTIt9dnFZVDzAp1iUrQH0iiPlqfZkVwCBUsRdQiUXY4n6e5GmQBU4hCQ==
X-Gm-Gg: AYBFou19mn4qWourhaA1aNEeuSJxa0x3GjBGFsEjHNify0IwmbEinwLWt4SEHqazBkp
	fiVI+iX2whb8e6FWh+EofOYFUfsJLKaJjj0MkJXjZ8DX7kOqvomY731uaGI86e1Vd6FX1MHKl7n
	pXgLPC1J1GzabTex/skEMaUObzW61N0Addzh+AnHhH8IcDnd2MmSiipWfnejdsrbS2/HD9F5ocn
	etT22BIFGWilpXhfvWDtGI5tGDrP7KIvV7b+YMPAqnI41tJ6Bqya/G6nBoY1fvk+lnIL5b5ScHk
	H0HraBVIEM5KeOyyNcfNHAM02hNBkdO7+8GNIa+Wjs9OR9bE/WXfV7N3V6WuDRi4SRqcku9FYvM
	20ndmqoHOvaPDuWLTlDLLJCHw7O3pRPKuIEL4MwwWadDV9n+ZF9Uw11+IM7B/wVA9nnKTLxuicQ
	JX96XAuEmgJQonv5AjE82TJT5ZzgyzNnXUtSR0s7gAKqQ5/RYilJPSgexC7Q3592u+QTx28l8F1
	bzu/GbRpW+N2hA3kGFG9v17mgMD3EnqehdE7TA1LjQSNk0QPWA=
X-Received: by 2002:a17:90b:1c84:b0:39e:4c97:ce09 with SMTP id 98e67ed59e1d1-39e4c97cf02mr704994a91.42.1789657961827;
        Thu, 17 Sep 2026 08:12:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:48d2:6852:2cc5:a7b1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d4cbc9sm13251302c88.11.2026.09.17.08.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:12:40 -0700 (PDT)
Date: Thu, 17 Sep 2026 08:12:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samuel@sholland.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: Fix i2c_bus OF node reference leak in ppkb_probe()
Message-ID: <aqwBtYAcIiwSSMmK@google.com>
References: <20260916184721.2093344-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916184721.2093344-1-vulab@iscas.ac.cn>

Hi Wentao,

On Wed, Sep 16, 2026 at 06:47:21PM +0000, Wentao Liang wrote:
> The device node reference returned by of_get_child_by_name() is
> stored as the adapter's of_node but never released, leaking one node
> reference on every probe, successful or not.
> 
> The adapter only borrows the node, so drop the reference once the
> adapter has been added, and also on the error path.

I do not think this is correct fix. The node assigned to the adapter
should stay alive while the adapter is alive.

I think we should convert of_node to fwnode, use device_set_node() to
make sure both fwnode and of_node are pointing to the same thing, and
set up devm_add_action_or_reset() to free the fwnode at the right time. 

Thanks.

-- 
Dmitry
