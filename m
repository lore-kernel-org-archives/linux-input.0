Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A72D7DC6
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114727; cv=none; b=YNPcZ53TGSlD2Nl7smQ6RK5cvCCsINT/LGtIhavz09cYLPgViBXOkg2NghsdwFPhfZYKNNfjKcCQNiYoybYfRMtIDguYwzTSGTEjHhdWrHBZpHqvpARJ2ikmdjT9g9aIV7t9ACS6a0zKoRCNBUK80KimD0YPy3mOLPKGau1zLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114727; c=relaxed/simple;
	bh=FWyu8ozkcAdq5Y9C83uXztT/PedhAAIx/kePam2jdnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMMiBz8FUbAhRiXcfPGdlEWibUmjlenp857qMqIo7bujgjop/ZgIMA6trkNTM3zSTWH3ThD7oLe0g+t542p4PNfXfloUaBcN0mmVodLg9tdoh9RwTf9uKMhCfoHwbIYxZ+0nXz7Za2f0yhFdkafhfwG9pZsaUnp0J3fCRUQE5ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdW/nAJK; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdW/nAJK"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30759632453so1416818eec.1
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781114723; x=1781719523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVukAwezMYUE1SCFZthKz4jvHB6lvQcNHMQt3G4qN+w=;
        b=fdW/nAJKh/uybtmNc/cTWqbewCo0Q+DTPFymDAR6gPkJUzkbseryjqW4NLh5XNgrJq
         tUr6QX0D1pFrOeHi++iF24xODakgaHklqvicxKbPKOwQRKUi3WRd+l2pzOPAX44tiAhj
         Kh+E377m32OmmaoyB458M9DVrQV+vdwYYNvbz5RlTDsImrAClAX+HWqYCveWGNzQD29q
         8CVduLdQUOaBUEF3KR8JQZmq7PYJuY8U0IdXAx/sLHgx+VCEMm7VNVjIbc0gZMaixIML
         AqrND6PycSsHXo7QTy4RYo3UwD3SfUFMUX1aVMOfaXx8dEuQuPF0UsgLLF/Znxu/wk0t
         X8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114723; x=1781719523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVukAwezMYUE1SCFZthKz4jvHB6lvQcNHMQt3G4qN+w=;
        b=i8/5bwLfDT9rxIz+9e5OL6zGPfdnqu210qOZejsc8vlICEbDcVjbM9LbUdUzKpr5r1
         HYpissEFuwcZqlwm6eVCTehmfOb7B992X5K5TZtpEVoAaJ5GYgEuc8J7BRaP3kgWyC2R
         dZvzohO7JnvQOWu3tZkDVRw5/6RPPEx/PhUX9e8Lgu/+nCYWOJ70cs5MPXqBCv1/KCNM
         somghLBQcJ9cSOkQgzpQdb1zfd/EgEDrc2NyFbHrEXeCGlakTmDWC2BWSKFniMhebIpn
         5po0QCWEsEGuFG4ZhReXb7dyNJ44rO5K1C/5TfCRrDhHmqGs6tu5Q4lj3kmLMAcJXN7a
         OPWg==
X-Gm-Message-State: AOJu0YzG92qJ2tbyLGKjdJ2kdWXJCc9V8bs1AIlQARhvKAyaOe2H2rbw
	fe8jgLvbJNtIqEztVi3EYTw6+oYZ8PQgOPL6yImWkmw+AuXr3sL2x7Am
X-Gm-Gg: Acq92OFFKGZG5Borq8tOjJsWcLiZxUFeB5+8uza7OckgjNLGqBicS9hroJ+JLeZg4ao
	ACGiocJgSPzHjLKOX0w42BPvN7/8xtQJl9MG3+Lz5ORSMCL5mWCIhelTjDl3p0BCP983L5C/kfy
	ZjIdq7tAEF2Stw06ZVG95+NAKdj707/6G6bs+5DckreNJ/69ISiKRT5uJFjZARJ7ZB0gOt6aL6a
	elfKbuljCfcZG69R/gG37dPJoLk1Rxj5qeGPOxo9ICE677AZ6QSMyeyNr/vh+bxDEZK6RozmGcX
	NMN4+hcgwDWkexKGAh2IPEwd/E0eaB3bdeJa5NHXyv8wKoiMRCQ9WYqBYIXyA2iHmDXPftX8Ou3
	OgfFyYBsbVCkz3Bfgqaj7qmBDQrVM8wtqRaFjcAKFz37jadjoVUbtBCPepVV/w+gYj1rY2eWW9F
	nDg5i82SVRDnUQWKOi7pgu54GSOCkPcU6uMm3KNvBr0f1uLhqmcFhJrON6W6xS3wFGNNLZmtp1J
	Zo=
X-Received: by 2002:a05:7300:5729:b0:304:e72a:d4d9 with SMTP id 5a478bee46e88-307ff5f73f5mr141084eec.19.1781114723164;
        Wed, 10 Jun 2026 11:05:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ae0e:e075:91c8:6570])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df75ff6sm27865265eec.26.2026.06.10.11.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 11:05:22 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:05:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Elliot Tester <elliotctester1@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: remove changelogs, tracked in git
Message-ID: <aimnXNA04j_K_qZH@google.com>
References: <20260514193302.117488-1-elliotctester1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514193302.117488-1-elliotctester1@gmail.com>

On Thu, May 14, 2026 at 09:33:02PM +0200, Elliot Tester wrote:
> Signed-off-by: Elliot Tester <elliotctester1@gmail.com>

Applied, thank you.

-- 
Dmitry
