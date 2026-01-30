Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5587837AA64;
	Fri, 30 Jan 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811872; cv=none; b=K7e+nVIaCsZlPbNoXtBl4SHzIH2rvS6ZODHkrTXTgow9ADAqc8zbXeA3K9qLVjtUzrimIYn1SlLWeHI9q6i9l3JIUchN/ncrzionUKBrqL43LOfFgG6P/ebDHtglMdy0M5bR26xBlv8wfCNMfNx8wXUN0MW+b7je7IVcmIf4/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811872; c=relaxed/simple;
	bh=gcswa17x7vAac8H8ISWVP/qXvu8V+YccoFtXeiHYCMg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cm4ni9w0WBycRAc9+Y3A3ty4bI6TCrWrgrUnNe39WAVGQnaMFqDJNqKKi+1GWrnOVoRNmNJdnT8mkpACxW1dpoNIdax/O8VRCncv+sZagLmMhE1kh90z9d7mehpeCLOUgnNF7syOKrwBrtOSarJDo8Ak1/Y92Mm63wW5BO0hgZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C294EC4CEF7;
	Fri, 30 Jan 2026 22:24:31 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id CC3181805A0; Fri, 30 Jan 2026 23:24:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, 
 sre@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
 lgirdwood@gmail.com, broonie@kernel.org, 
 Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jserv@ccns.ncku.edu.tw, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org, 
 Yu-Chun Lin <eleanor.lin@realtek.com>
In-Reply-To: <20260113092602.3197681-1-visitorckw@gmail.com>
References: <20260113092602.3197681-1-visitorckw@gmail.com>
Subject: Re: (subset) [PATCH v4 0/6] dt-bindings: goldfish: Convert to DT
 schema
Message-Id: <176981186782.331784.16669920696929509019.b4-ty@collabora.com>
Date: Fri, 30 Jan 2026 23:24:27 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 13 Jan 2026 09:25:56 +0000, Kuan-Wei Chiu wrote:
> Convert the Android Goldfish emulator platform bindings from text
> format to DT schema.
> 
> Most of these bindings are currently located in
> Documentation/devicetree/bindings/goldfish/. Move them to the
> appropriate subsystem directories (serial, input, power, sound, misc)
> to align with the kernel directory structure.
> 
> [...]

Applied, thanks!

[4/6] dt-bindings: power: supply: google,goldfish-battery: Convert to DT schema
      commit: 4c3f02f843999a590f4481791f59a2f9a7f34fe4

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

