Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63B9186E58;
	Sun,  8 Mar 2026 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772961333; cv=none; b=pCUa9BqGa6S+7a/u+DlEMDO6u7vIzJ5CzMcU992CY1ZF2s0ftvH3NBWbq+5mp9wab6EBCHZI0p0L34x/4TDGoPhNIC6Lw7CC4sLFPTxgwUUc9IWCevaXMz6UXPqJ+MDFjX9IXvuGu73sMEVYBUs9F9nDQenx0gy04H5SeoWSwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772961333; c=relaxed/simple;
	bh=XWI+ZHoUAT3ctskDKws+HHdePkXTEbH72ogQ7cjOWWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQaDmI4PII37TWtjiGh52CnaY8cJjycH1AG9Jy3dak4R+EP06yp2WW7LxycQUbEu7zaUPOQNvleMO3yHa4fHsuTlDWz7O+aV3YFRNIznBVY+KnzYiDyzmRjgFqVC/vHYGE45lpgHP6jvcNwLDeSAo8fI7kxYGqkolD7FohXPXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idVhnbav; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idVhnbav"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A34C116C6;
	Sun,  8 Mar 2026 09:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772961333;
	bh=XWI+ZHoUAT3ctskDKws+HHdePkXTEbH72ogQ7cjOWWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idVhnbav/XOwlumIv3+Uf/JNcHhq76ZoBvHozfMckJ4bF9h+cDAZf/Zz+JTfl69Ek
	 nv5QEBFlJqDQwHUAyCK7x9oRzBMFgPCmdl2ouzjvo0vVwKX7I6mDBnfZYfSoRazGQJ
	 oKlFQNK/3V4pjEd58SVefBl0vApoOEg+lwOedsQkB+h/9DnG+BRSBERp3dDoco/Kt7
	 skYma1ib5R/P6X14OcBDg6vE6kElezZo4px3Y0WB4RhC7Vj3ERe/mzUEOUfqzcLHWv
	 6lQsKCObsnISjHVMlubGU9v7pJ+WsqzAeCJI2+MnSmMmE/IyCV+OCIee/bWQ+twdk0
	 6DjSs63mfWYlA==
Date: Sun, 8 Mar 2026 10:15:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hendrik Noack <hendrik-noack@gmx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ferass El Hafidi <funderscore@postmarketos.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: Input: Add Wacom W9000-series
 penabled touchscreens
Message-ID: <20260308-vivacious-coucal-of-current-2d7ac8@quoll>
References: <20260307181557.66927-1-hendrik-noack@gmx.de>
 <20260307181557.66927-2-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260307181557.66927-2-hendrik-noack@gmx.de>

On Sat, Mar 07, 2026 at 07:15:32PM +0100, Hendrik Noack wrote:
> Add bindings for Wacom W9002 and two Wacom W9007 variants which can be
> found in tablets.
> 
> Co-developed-by: Ferass El Hafidi <funderscore@postmarketos.org>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
> ---

You received review and instruction what to do. Did you read it?

Your way of organizing your work makes it difficult for us. Look, try
yourself:

b4 diff '20260307181557.66927-2-hendrik-noack@gmx.de'
Checking for older revisions
Grabbing search results from lore.kernel.org
  Added from v3: 2 patches
---
Analyzing 16 messages in the thread
Preparing fake-am for v3: dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
ERROR: v3 series incomplete; unable to create a fake-am range
---
Could not create fake-am range for lower series v3


Best regards,
Krzysztof

