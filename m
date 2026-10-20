Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514042;
	b=gI5GRF/Ko7vxE6Kf76w2IFbSRWDxFMGV4nvlFIa92A++OyO9WDoklVUUoAUzTH4nsI/X
	 bcHAu0Cpjn4R5ehsgSP1riDoq971u5azyJBO5LytEexurYfnGgiH5usqx4pdo/ZdIWRfr
	 /9Mw9dT516cuNOu3qmTnNlr74N3nhYZCPQMjzm35WloROhpqR5EKYMQ0B0wprF/Ax04Ld
	 8UGaxFkuh0zOV8dLUJNh2TWUTOhjYO3dVQsKjyZxdIxctFFyQOo2+AoKKN+fCKJ7qFe2M
	 Ohz5HOUhC0kRmJJuqMZmKWWF7VM4YWcfnTxwQfGd/6ATNAtxDQTJd+5RiQcLlPnzWQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514042;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TxZzEjDX/3DLLeCR+G79n9PjIX7hQ/yNvQEEe5aTZAc=;
	b=CXMPKvlB2NjWqwoWnOc4bSJMw8Kpf1VCcxJJ3ugiEFi556LslksCYAWvr3Jq9lWJCYOW
	 qImHkTd2wFbIgwERdb/CSfrWBsvsN3jhSn8nVVGHvUPs501NHnAvZTTzDcXNx6Z9FsoTi
	 vAon177sgYfw9230Sd0u7zd6xuuRUh72qKx+dqvpRLcdy7mjR0alWb8OsqHCtkcqKL9yx
	 AdJXnlnqQ8tLnjPF1CNNKwWFk6vgAs48X/x1oAa4vXdgQ0ilVA2sQ7JGQgGM7Z9dmmkcw
	 VguVxdC8LrXQcs0/JK+fR6Ij4xDSdEsC2APQ3FZvAg8HXtahIuS50NEFGiN7/Oi1jkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LT9jchQL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523E8606A319;
	Tue, 20 Oct 2026 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LT9jchQL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A4B1F000C4;
	Tue, 20 Oct 2026 16:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792514041;
	bh=TxZzEjDX/3DLLeCR+G79n9PjIX7hQ/yNvQEEe5aTZAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LT9jchQLnHcoLQxSbf6fw1zSzIU2BepG2M3CnuBl0Spw1fBqAAxvdrcTXuxTeSVhT
	 B5L97kFZ/rpjT509+NrnxshTsCPS/HUtpk/nxA4tkHrxZ+DQkJJg43i/4b5Lgcvcwg
	 sQaf2vV802kf6fy1+g+biWqGksacF9JwNwSDl6TofUFh3RYAzrqNnVgmY7ipF7zE+c
	 tK35CIV/owIhWYJwXaLXEbbnYnvEHmFd07YIwaJuxVzmDtiiW/42MQwXYXnYqQ507h
	 wUBNWfL3j5c2eRNIVnFH6TpbvJYlaRjwSCxWT/ccTpj/WjMzDLXk10WfyVWR57Y/Az
	 PRa3AE9I1ZCdw==
Date: Tue, 20 Oct 2026 11:34:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, daleyo@gmail.com, hbarnor@chromium.org,
	Steven Rostedt <rostedt@goodmis.org>, fqwqf@fqwqf.xyz,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org,
	linux-input@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Dmitry Antipov <dmanti@microsoft.com>,
	Jarrett Schultz <jaschultz@microsoft.com>,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, tfiga@chromium.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	devicetree@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 08/11] dt-bindings: input: Document hid-over-spi DT
 schema
Message-ID: <179251404048.4017131.1730464823799910266.robh@kernel.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
 <20261019-send-upstream-v6-8-cb9ba4b3d6fa@chromium.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-send-upstream-v6-8-cb9ba4b3d6fa@chromium.org>


On Mon, 19 Oct 2026 19:01:20 +0000, Jingyuan Liang wrote:
> Documentation describes the required and optional properties for
> implementing Device Tree for a Microsoft G6 Touch Digitizer that
> supports HID over SPI Protocol 1.0 specification.
> 
> The properties are common to HID over SPI.
> 
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> ---
>  .../devicetree/bindings/input/hid-over-spi.yaml    | 130 +++++++++++++++++++++
>  1 file changed, 130 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

