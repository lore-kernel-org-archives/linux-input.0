Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9F0282F3B
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756302; cv=none; b=IQ/fptYNGvusU8DqeAqFYgMCRa9oeWm8LJG/ax5KA/w0N5IJvRNJN2L4HgZzSmdpOqjg1vj//D3nBaiiD2CpR55y9GI6Jb2Y0Kr+j+2ZuI1eZz0DJQoHs7/dLZAgmrezkuDZhpgr3nN5skJtjZ2TO3yvPU9K0n5ANsaPGSoARd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756302; c=relaxed/simple;
	bh=Lzbvx+UbpCOhAC36ParUUNbNJ6sRwTxyZCatiAgTxWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unqeITP+GkOPDwbgfuMQr0QSQXzwM2nw3p5b/I+OVaFaZNeYbr7QB7OGD3ulgqNV90TIXVvP85NLaNmUn9fisj5wgD1cFTa5/d85GHpKynW+fJ5jEu9xYb5hNzQC1xv2gzrds2d/n30Tq45s0YI4ro9EAZmlIdJvFrOaW8NhGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKSLCSjF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKSLCSjF"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37fdee9276fso1482630a91.3
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782756300; x=1783361100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lzbvx+UbpCOhAC36ParUUNbNJ6sRwTxyZCatiAgTxWI=;
        b=LKSLCSjFAgxVgdE4y5jRrgAYezonj9p6ellb2/x2SEKBr7FC7yNhJ9X3JW+MMCpYBP
         o1ZSF+GbnI3wSfb5yn37cSHrgvmWURXJrCp1Jf5sDmOxItrWc95S3IWUVkPKaCNk47Az
         7qGu556XRgv+2SNi/2veZl38yo2GZOoUVXWztVL74xDxvx6MtANGIqqOCaBrnlYN5P0R
         tM9TlW84obHB8O/sewMO7yKruC9mGmUPvnz57PYIGEXXOSkyyrNRtDq+gK+nJGcpX2ql
         LOygf0QBvAUaW/wbwMCZt/aY8w+RfQZVkIsuX22x081TGxiH2kffxiRD/LZy5TbXj/k4
         3MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756300; x=1783361100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lzbvx+UbpCOhAC36ParUUNbNJ6sRwTxyZCatiAgTxWI=;
        b=iM26VaO8/vned/5eM2qeAKdpb/d2BpNlH3wi8vvOwi3qJrvF9gghajtIuJX68f5scS
         jREgBdL63bRz1YfcUtJ4SdSCMk9Yamw8AliEuabaH3LyTQ0QNRgyGMjzCmPL5BmIxhxq
         /vuIYYbrHWy2jyxwzR10MSoT91MY6dnq6QE/lCYFKeitaHsv7E5AuknqgFZF+/N/LxIN
         N0akP7D2UYPlakjNpHFe/h59w7sFi/T8jiGmmoKKUAThi15SnJqec2wqpLKwd68yi66/
         CkJYjf7XaI1ufoyYx2hsTqFO5wVVfEEFNO4eKs1ohdwuPx3NqZpL/X/UMjUsKcfQT7Ss
         HR3Q==
X-Gm-Message-State: AOJu0YxNVzNSGYfO03T7feME4JwnAXOdpuBDjiTesMGhl5C+Cc4Jl/8+
	D7faGP5PlGYT4YGxOc6WQv3VFZlMCfN4AmOOMsTIfFp/OK8VYRCVMvFsN9Rm6fvMSTDg5Q==
X-Gm-Gg: AfdE7cnHte6jpPKfMKsQForyNtqfXr6mw+JAWFZKWVgeDupIx3A0Ry7BHkZMOGWSlw9
	YVGw7B+1bbNwBh+L8HCFMG+OxHZ4ioxyYrbxghPVL2OsJx3YMvY6V7qMxYHBk6JplvsySEtGv8A
	67WF36QnVVNEXAo4may5mjEnJ3JL9iHpM0aH+TOGdXXhLlI/3mUJtyA8m5lCW9NpoXjGTI+V5z5
	pt9frUdNo7LH2OBfJ6YuapFyLsNCFICzDDOJ8VCK5ig+jdfjapI7bc0rb/JHhnjmz3w7LLQnahd
	CefqkpjYOcvC3/4wWW2RwGp26gL54uhWZYrNUbwpTtNWNM+CAEozU2cxG3zEZECH2K2HGAXZi1x
	bi3gyM9MgS6a5v6F9FXTapTSlgxVodyDgWg+lVuVB1cYnB1ZVerHExl0MqieWX1pMAtbXJf3aQI
	0EsrR5A3ZmEYdmtEr5OSUXkUwem2IKbmKYQFcVTSiKxQIvQRVW
X-Received: by 2002:a17:90a:ec87:b0:37f:b91d:89c5 with SMTP id 98e67ed59e1d1-38052757198mr277384a91.19.1782756300252;
        Mon, 29 Jun 2026 11:05:00 -0700 (PDT)
Received: from anon-laptop ([103.147.239.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38052bf62a3sm134005a91.0.2026.06.29.11.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:04:59 -0700 (PDT)
From: Wahid7852 <wahidzk0091@gmail.com>
To: linux-input@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: jikos@kernel.org,
	Lixu Zhang <lixu.zhang@intel.com>,
	Wahid Khan <wahidzk0091@gmail.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ignore post-init ENUM_DEVICES from firmware
Date: Mon, 29 Jun 2026 23:34:19 +0530
Message-ID: <20260629180419.383303-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627224753.35075-1-wahidzk0091@gmail.com>
References: <20260627224753.35075-1-wahidzk0091@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wahid Khan <wahidzk0091@gmail.com>

Thanks. Correct sign-off should be: Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>.
Should i send a follow up as v2 for this?
