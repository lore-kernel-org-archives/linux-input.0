Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C4A3ADB89;
	Tue, 29 Sep 2026 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671233; cv=none; b=bG5SJfabHACHU82iFqFyBJnHSAsPASGhEAVPzQ/ynAbq7bM3zrWwweI/3+VS/OvW6duSqXKI1Yj1hL9P7G5FlhgTK6vTUNHlIoSgUJc//P21rEbfIx6uIAvzl+JUUv0JW+XMWgSp/Mfsb66+MMWlJcEDe2nHaabqwNLBX981qbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671233; c=relaxed/simple;
	bh=Aa6xYmK1NnTvuK2o2Uu6k+mRLLRVlvUUTVe8tXlCKMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKI3irhT0cXQKpwKR92awpa64EiKZCew6M9S6QGE3TL5/8SuuyFCNRNPMk4COplUpdeuaobJN2uKFVRthhR3XLeYAImysWYVlTOgS8upvylM6AiP4EDBAFIJXmqXPzeNOoXk+c9Jnrtbzo5SbLdmW2qtXAsA5mJucX1NuBKnClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7UXzj5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7UXzj5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54851F000FF;
	Tue, 29 Sep 2026 08:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671231;
	bh=j/CLrtLe3fBJ5VYGQS5tjlTm/0gBXqbRsnQnrAUdh0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b7UXzj5G5hYhlifBWvT6qdrIYlAI4T3HRclnX9E1LyQnzSqpZ+B7e542BqZN6j5Qm
	 n+T4qs2S5MLg542Uwg1EbLTSeHsN5KAyhtggdlfyRBN+rLGb7JTsb4gRBNVIY48yA0
	 GagFw6DwbzwFbtRFNsDNCRZcQBMedT5rzWTFGOYqDbFfZBc9YZ5QtYqHqO4NFiZJ4u
	 hIzg3RTWna54IhStecRwt6JqYkki+HjnzDx9nUPX1j4gYJ4xSSfHJ93ymg9BmlKqH2
	 EQbhwsxBGtta+nF4DSWAn0e0MOJeYNAgCjPEdZKVCpCuS29xUDlXwhh5EFe20ToGlA
	 cnUbf4aGTmXIg==
Date: Tue, 29 Sep 2026 10:40:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Petr Hodina <petr.hodina@protonmail.com>, linux-input@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v8 3/5] dt-bindings: input: touchscreen: st,stmfts:
 Introduce STM FTS5
Message-ID: <20260929-vigorous-cyan-chihuahua-b0e4a2@quoll>
References: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
 <20260925-stmfts5-v8-3-0fcf49e2c85f@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-stmfts5-v8-3-0fcf49e2c85f@ixit.cz>

On Fri, Sep 25, 2026 at 11:22:21PM +0200, David Heidelberg wrote:
> Introduce more recent STM FTS5 touchscreen support.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/input/touchscreen/st,stmfts.yaml      | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

