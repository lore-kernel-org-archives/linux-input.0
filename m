Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9520F304BDF;
	Mon,  5 Oct 2026 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220087; cv=none; b=VHB05+Ejf9EnCIBBmIEbU1VcF19xRXShUh3uni/2zZ/MrtMM+ajOFo4KgWMfTrdiRlZTGjj//Np1Y5hrJWPFqjWzpEoOXN5rE/Qlx5PL86572dwhJfiti5h4SWozw/m8ZR1zhQdWxT6ubvFQKfAIiTgJzpkQWv8JYlqFxnnu+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220087; c=relaxed/simple;
	bh=kjfeDDCSUq07CACGdCMkRub8JM0Xwqasras+7cQQc+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyHrzA0J8jA5H20j0efKqHt8jmUV3Qml3pcG2hY7T46a3FNbJvnXKQ6SOuHwCMUBFcNe6SS2Ps6ZHnkGpilSIb+pR1gsNs5gK90a4fT1RyACixnKnbNJcsmlWb6SPi6XDYOmxuYMsTAElNRNwOkxycd6uk/2k8wzgrXEZeEgank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xDmAM-000000004jk-2moA;
	Mon, 05 Oct 2026 17:07:54 +0000
Date: Mon, 5 Oct 2026 18:07:51 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Oleh Kuzhylnyi <kuzhylol@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hendrik Noack <hendrik-noack@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chad Monroe <chad@monroe.io>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH v2 3/5] Input: hynitron-cst816x: release gesture keys
Message-ID: <asPZZ4Dk56iO7NYF@makrotopia.org>
References: <cover.1790944534.git.daniel@makrotopia.org>
 <7199967eb45b1c3adcb7efc859380f6f3dbf7bdd.1790944534.git.daniel@makrotopia.org>
 <XXX-PASTE-MESSAGE-ID-OF-OLEHS-MAIL>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XXX-PASTE-MESSAGE-ID-OF-OLEHS-MAIL>

Hi!

Thank you for testing, and for reporting the issue.

> I suggest either gate the gesture branch on tch.active so a finger-up
> single-click never fires a key, or fix cst816x_gest_idx() to map 0x5/0xC
> to their own valid slots so they stop aliasing the TRIPLETAP keycode.

v3 takes the second route. cst816x_gest_idx() returned
CST816X_NUM_KEYS - 1 for every code its switch did not name, so single
click, 0x05, shared the long-press slot. Reporting the key with a
fixed value of 1 is what made that alias visible as the
BTN_TOOL_TRIPLETAP pair in your log.

The lookup now yields a keycode instead of an index:

  static unsigned int cst816x_gest_keycode(struct cst816x_priv *priv,
                                           u8 gest)
  {
          switch (gest) {
          case 0x01: /* Slide up gesture */
          case 0x02: /* Slide down gesture */
          case 0x03: /* Slide left gesture */
          case 0x04: /* Slide right gesture */
                  return priv->keycode[gest - 1];
          case 0x0c: /* Long press gesture */
                  return priv->keycode[CST816X_NUM_KEYS - 1];
          default:
                  return KEY_RESERVED;
          }
  }

A code the driver does not map is handled like a report that carries
no gesture code at all: it releases whatever the input core still
holds down, rather than pressing a key that belongs to another
gesture. Single click reports nothing of its own, so a tap is
described by BTN_TOUCH alone.

I left the gate on tch.active out, because your trace shows the
gesture codes arriving with t: 0 on both the finger-down and the
finger-up report, and that t is tch.active. Slide gestures reach the
driver the same way, at lift, so the gate would silence the keys this
series is meant to report, not only the single click.

If a key for single click is wanted, that is a linux,keycodes
extension in the binding and can follow on its own.

v3 with that change follows. A retest on your CST816S would be most
welcome.
