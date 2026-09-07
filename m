Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C443F1046;
	Mon,  7 Sep 2026 02:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749063; cv=none; b=ZSEWavwPxtE/NHLVdr+uE5720RwxtOu0JzOVFxsZ8tpbtjfse1OQsDfZbOjSBWUPGclNt4s2C4/SIqZaIXvB1C4Rina+6MnyVAB0VOd1vsTnANZjigIgaTZ3jqpl32iTOZcX7WITZTeBoWCFZhxsXxnAXchA0LopaVZl/Mkil7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749063; c=relaxed/simple;
	bh=c8jW4Y3oIvOH/yBeYZIq2At8l4DS1lwDGk4khsrQ+pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uonViX/1pzG1UYulCMmC7yNAz6MrvIRWaMmJOXfuQyTfjBqcdRD/tninl28ekb/xUAdAS9okuuIDxazVRgf/sY1BrWg873yBfVUhNYAIrnawbrIOBp6bXoUT2iQs4eU1pxcr+LEi1XoHDB6vxux4Q73ALVtLOH8q7Io8pAMSLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/5OPeOd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/5OPeOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788749061; x=1820285061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c8jW4Y3oIvOH/yBeYZIq2At8l4DS1lwDGk4khsrQ+pI=;
  b=Q/5OPeOdCnoKKQDICOzC+0bLYZPlPjXn1V26SiK51GKVbr23PJ124HpI
   imDbYoF0DXKv4azfdZaFNNa8IwH93v/LgD/5a547j0TQikFEPCWd8mQON
   Ds97LTEXDniHBOK5SOD7qJIvSCL27BiO/RiEqCyAASlX6yTxTO/i9tuZX
   vqSFPOvHR0dQcoUuP2FJbFp515iQ+WQXLYLL2HbpsV6FMCGj7flbIeSv4
   f7amDSH3anVYGDMR6wSqcm6SgrLdxszarCiX0pebnbJNrAbY5jPTFGm9C
   GGjRWmGyLL0UeY5zEiSnvqfm2Ac8PSFCSdgrCaYJOTvwg7oWq7AfrsS4u
   A==;
X-CSE-ConnectionGUID: u533vQmAQrOg2NuGDjLClw==
X-CSE-MsgGUID: UE8ctQJBQgqrhTXDjyT5Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="99744369"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="99744369"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 19:44:20 -0700
X-CSE-ConnectionGUID: fEMTx9TfSCGvWZKSEo3n0w==
X-CSE-MsgGUID: ncTqF6AcQdCwRDWuppDj6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="266901553"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 19:44:18 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Marco Carvalho <marcocarvalho.web@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: add ALWAYS_POLL quirk for SDINNOVATION gaming keyboard
Date: Mon,  7 Sep 2026 10:44:08 +0800
Message-ID: <20260907024408.482401-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824031419.316315-1-junjie.cao@intel.com>
References: <20260824031419.316315-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ping. Still applies to hid.git for-7.3/upstream-fixes and
for-next as of 2026-09-06.
