Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E0B394780
	for <linux-input@vger.kernel.org>; Mon, 13 Apr 2026 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118984; cv=none; b=jjqx/4yeMbJ4ew8rNFfuBVDJBN3YFl7ZDoUuiPTEqm3GGqpXyKC3uBntpPHgHBDyRht5jUC0WYo8x9GiFNTpthUaocQGFdWy0WyzAgL6odtbOb+nA28oftsdxc8szOMh3VO2Syjy/tLX329L3WVpDNIj9Ojp483IhUFAzMdVsPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118984; c=relaxed/simple;
	bh=CyjhnVCJyeQHXQh3TCvfXIK6p+8kUFavini0sIY8G1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tOgdjfcK0PHoxKc0obX8bbvHRNw0dQVJdfloZ8qcKEwxyKZoaUixBLuZiGh1T7WcKF0OkOZPVbkn6aobEzSUOfhWLEyfc41QaCwvd9+6AgEl0+bXOMIelWOjdhGXx+k5pXT3TOdGECih6uEAuNvbpipZzLXSPTdJXXNp6HSP/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrcgIgIu; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrcgIgIu"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-662efd1bdd4so2460343eaf.0
        for <linux-input@vger.kernel.org>; Mon, 13 Apr 2026 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776118982; x=1776723782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBjjFdKtvid+b3yYlgINObv/j9SDh6up5Phk1D0/oWE=;
        b=FrcgIgIuoCkRVf+xI1hWE27Nr9iPDFf5/xtXSMYfYNMlPEdnO9NiP4QccFJSYY4rQp
         wyBNRh2bplHs/rUK14ZwbxQrKX9qGLg7uBpNNqwBoqZQdgyS6HAE9qsLEYJKvLpT2vS9
         TCHZKnfwkdW/mpldaAPmX32UCRdJgTc4diIGylxJhy8sFXzXzZd4/kPzflyDQtFzyX4y
         UxUOatj5FQMiYPrExLXWW6kaNyCwSLRFcTCoVebCaOSvwNf1g5qnrXvPdeiM+T5Qd06m
         HZrDx61YMQ67MHP7Boiyj23nkw96ET4IN/waX66k/99QLwXqSgDYUwHTFPFbIrd88SIt
         yKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776118982; x=1776723782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBjjFdKtvid+b3yYlgINObv/j9SDh6up5Phk1D0/oWE=;
        b=OMUCn85s3YhYjyKfdalYoO5bjHlBdDQHBeC+ajNNWNRfLoIdkE8D8toLlKR3wfu3/7
         /TUlbBnZdeVNLCZjpTKNf2E21VO4MgsC/voUMYgvL0ErVruKjrA2pq9/3jm/KjxdlFiu
         zAbEOYy8gBXrm2s1EOrOFNkFT927gNio+68a0NjgCVWx6BlAzuhyVv20dUxLBJLb0V60
         sa8Yr17xdhIdR45Oy2p1St26VZ9p89SpEA4y28sgx8VLQeQijxzs77jYVBTHQLZCGXLq
         JxekQNV/7+Zw9uEoJRqNE7tL0R6+w3LqQjGS7Ld4S3ktLqUCA6kFr0+6Se8e8dNGjGaT
         7pVg==
X-Gm-Message-State: AOJu0YwHxApLDSzy5myOKC0N2uKt52GS6vzNDpFoR8EbLfgAcwfhV3xz
	yTIkmkhoT7j0rHZqZDZ+yFhRkWbS3TfYfz1NY/P1i9/8xKJ8wtNNZMrq
X-Gm-Gg: AeBDievYpC6OqDvrx33yNvC+vVWJSvCa2gBUp/ojMQtHkt7Mtxk4Z+0DYX9lyXZ5lRW
	1Iv1kPAPXAxZ+hJdZ6K9C+OHaSa+yq7VxgPFc7/urKsYDnhnULKd4I0wgv9Mb6MgDudjwAqnSB7
	Igyq7I2cym7Y4nlS6dVl8Ry7oEePZoE7iVRC0NP8LeENpbFwqQ05dGh0Xy125HC6HQlPFV6QSMj
	McJwA71QZG5OtW2LMm8NMDwg5ZGhxBoAOB2FMZNDN+xTOHFmmgzRBSpoArVzNWC/2Pr1SECgxHu
	uBuaqDDR8qkY7KgRp6YU5+Cq+JIfel17ssM91N0SHkXnlnnQm3f9D04YbR3yaQzn8b5qhnWTLa/
	CpBkiH6qLKwtibx5DY1bvVnzrbTJUx2Lb4FGwtTQyT0odCerEI6FRgJwRlHZqECAScwnx5vu60z
	wJ1/Wg6BVZSIz/aHrnMMr4z80UET+TEdhTJlRH
X-Received: by 2002:a05:6820:1505:b0:683:310:77c0 with SMTP id 006d021491bc7-68bf83c8996mr6327244eaf.23.1776118982401;
        Mon, 13 Apr 2026 15:23:02 -0700 (PDT)
Received: from Dell.cheetah-searobin.ts.net ([2600:1702:56e9:4b40::33])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb80ccesm9403198fac.13.2026.04.13.15.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 15:23:02 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akash Sukhavasi <akash.sukhavasi@gmail.com>
Subject: [PATCH 0/2] Input: analog: fix coding style violations
Date: Mon, 13 Apr 2026 17:19:26 -0500
Message-ID: <20260413221928.21748-1-akash.sukhavasi@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series resolves 15 errors and addresses several warnings 
reported by checkpatch.pl in the drivers/input/joystick/analog.c driver. 
The original code contained multiple instances of trailing statements 
on single-line conditionals, as well as minor indentation and spacing 
issues that are in violation of kernel coding style. 

This series breaks the cleanups into two logical parts:
1. Fixing trailing statements (moving them to their own lines).
2. Correcting indentation and parenthesis spacing.

Several warnings are intentionally left unaddressed, as they require 
semantic or functional changes outside the scope of this formatting 
cleanup:
- printk() to pr_warn()/pr_info() conversions
- simple_strtoul() to kstrtoul() conversion
- Filename strings embedded in printk() messages
- Quoted string split across lines
- Suspect indent on fail3 label

Tested with: scripts/checkpatch.pl --strict on the final patch.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
Akash Sukhavasi (2):
  Input: analog: Fix coding style - trailing statements on same line
  Input: analog: Fix coding style - indentation and parenthesis spacing

 drivers/input/joystick/analog.c | 49 +++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 15 deletions(-)

-- 
2.53.0

