Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBE4386456;
	Tue,  3 Mar 2026 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522671; cv=none; b=XUoJ8ZBpS+xwkhaz/e1Rgl6EXlKpd6Lxs9HdHVd9usn5Nr73TO1VOeQdmG1nrwVcb0KcwHe38NnaszMV3aWnqEWhUmO5Ta9v6iz3p+uycLsqg7CAFR/lQVj3B/QJ93LjIA6k+GNxAF8PE97f52lrE5RCUm7Wc48+x2XFdJq4ElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522671; c=relaxed/simple;
	bh=QZft4tGQpuvbjBTEEEvSJYL99Aepiq91XDG/qGhbh2U=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=S4TpJ3zxOYBiQZrvMbQ+MbksQKX3nIEf5wOSPYPK5g9prp9j7tM8cvFRzrpvNL33Dld2Qcu0O24Rvui0cegru9zmCtM6RvRb3YWxBvxQlQTCEDr2Um32hkMJupk8bwpOnnikjriEJOGQKeAxyslzREOKoK3qC79HF4t2ZG4p2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CumCzOFU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CumCzOFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29555C116C6;
	Tue,  3 Mar 2026 07:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772522671;
	bh=QZft4tGQpuvbjBTEEEvSJYL99Aepiq91XDG/qGhbh2U=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=CumCzOFUtZqcX2cEkO0qbJ7HgPEArgGAHGrdvxRnYksDyKfc+E2PnGCBDHFSpgJ88
	 qw/tpX7Y4ifWZSKeOvez0pyBFPcHcFR5OOK2mzBng5IWhcjrAeraVLn3hvGG0DzSV3
	 0vO3CyW4+Ndfw4Ng+gzNbFFDHrjtViseftgqYjoSnOCGLWa7kVtmfkmRowtA5ztxfB
	 CWy5EBcZydl4miHogKhCyPMFisU1yFQ6j4/eOfLse1txS5xR7BaNPCdYrmmjJja5Zl
	 0Isua/vIPYOtqgJcUWnfboPYkBbr8wX/NnBVkfJe570MEUSMCt6yX9NJrju1rGrsG4
	 vDT9axQFRKN9w==
Date: Tue, 03 Mar 2026 01:24:30 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>, 
 linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
 hbarnor@chromium.org, Steven Rostedt <rostedt@goodmis.org>, 
 Dmitry Antipov <dmanti@microsoft.com>, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
To: Jingyuan Liang <jingyliang@chromium.org>
In-Reply-To: <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org>
Message-Id: <177252267017.1911710.5393390799820908682.robh@kernel.org>
Subject: Re: [PATCH 09/12] dt-bindings: input: Document hid-over-spi DT
 schema


On Tue, 03 Mar 2026 06:13:01 +0000, Jingyuan Liang wrote:
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
>  .../devicetree/bindings/input/hid-over-spi.yaml    | 153 +++++++++++++++++++++
>  1 file changed, 153 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/input/hid-over-spi.yaml:67:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
./Documentation/devicetree/bindings/input/hid-over-spi.yaml:89:15: [error] empty value in block mapping (empty-values)
./Documentation/devicetree/bindings/input/hid-over-spi.yaml:153:7: [error] no new line character at the end of file (new-line-at-end-of-file)
./Documentation/devicetree/bindings/input/hid-over-spi.yaml:91:16: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/hid-over-spi.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/input/hid-over-spi.yaml:91:16: mapping values are not allowed here
make[2]: *** Deleting file 'Documentation/devicetree/bindings/input/hid-over-spi.example.dts'
Documentation/devicetree/bindings/input/hid-over-spi.yaml:91:16: mapping values are not allowed here
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/input/hid-over-spi.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1559: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260303-send-upstream-v1-9-1515ba218f3d@chromium.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

