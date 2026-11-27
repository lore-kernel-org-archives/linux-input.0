Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791141;
	b=Kis0WS5pU+NgLalqObyTwJSSHbQzTmcD8t944vBO/j58OAXZFwxEw550BMxvBl5ikCdO
	 +cCYVSmAqhmdlRnBdT6fjm1nYJeQXxa1CScng+V/rvtLCxWdEFFOpXikrfXp1+1ZFJRmO
	 8PHsER3PXy1nnT1UkOokKiajnOayXfvFjIavSMjW7Fy/ekK73LFmWb23nEDN05xPPcV7v
	 nUo7abnM48gkcZl+pKYjHZFgM0m4sHs02tfr8gtcNkdhQfmKnUjV2sCuRhkQJ2Ne2oDzA
	 ISZF46AruhVr0y7r70n9l5fywzDtJO6GmQQ9ZJBCoDnaPvIvtpqjKsV1TCnZ2wi8IAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791141;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ViIYvpZIhMJ7TClO8IOUS4WI5vPYwz/5cCK8mOs6oYY=;
	b=Nd6AqDOo9sGHI/cckWIQKgEulLr4W+ECgSdiiaFk8ouy8RoSPKyvBHV/A/4czo6Ula/o
	 7h3vtMv1ZVETTp0cZ/u9t1Onji9ZrcAOWUd3yVBIX5n/W4jg9BcjI5U1g5NmifG27e7at
	 0oIF874JMF/qQLU5zbH2d4XGQouSDl20pHmgOwtTnIZXNyP0iQkpHmIQbhY2yUMBtmPBt
	 mdgKE/aBmKDlQrPW771F7SdwCFyQy2++lckwtcKG48fp6YtLXoOOEg7YVAZhQfhhmRG6S
	 w5J30hvmHrMBsxcGU9dGlzkb4l48ZNzPwORKGj7/bhVPJR8vX2UI1ovkPlsJ6IirO5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WA9iqKIN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55102606A31E;
	Fri, 27 Nov 2026 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WA9iqKIN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA1E1F0089B;
	Fri, 27 Nov 2026 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791140;
	bh=ViIYvpZIhMJ7TClO8IOUS4WI5vPYwz/5cCK8mOs6oYY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=WA9iqKIN/dcx4DcXYzIf0iT5XKjj2scrpfadsodaXRIFEBj46fUal3SLoVBCqVE+R
	 IYmLvTphGKeJDGseqRRKaAf7r71J3DP4DSIxgDvDKTFal70s//026JgmeUJm3gvBqM
	 begpCiYqWsOxwIT4rET/ISUyZcQHCJ8GpMXhnxtNjd4kZojTYBr7cy/IKrfAYS0Vw0
	 LlQCovGsRINBIYFpgmkkBWzBZ3Zkoyqr698PMPTmMQAC/QruBsjLsjtGPtoMWUaBET
	 9a0jeX5zmlb5dTG3rPyLK1SlU47K5ndbrswZhAzRYqmw9PfwC3DpqVk6chXJzqPF26
	 HOjovYA/BAQUw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] Input: matrix_keypad - validate GPIO counts against matrix limits
Date: Fri, 27 Nov 2026 14:51:54 +0000
Message-ID: <20261127145209.2884170-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127145209.2884170-1-lee@kernel.org>
References: <20261127145209.2884170-1-lee@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

matrix_keypad_init_gpio() obtains the row and column GPIO counts via
gpiod_count() and only checks for negative error codes before storing
them in keypad->num_row_gpios and keypad->num_col_gpios.

If firmware supplies more than MATRIX_MAX_ROWS (32) row GPIOs or
MATRIX_MAX_COLS (32) column GPIOs, the setup loops write past the fixed
row_gpios, col_gpios, and row_irqs arrays inside struct matrix_keypad,
and matrix_keypad_scan() overflows the stack-allocated new_state array.

Reject counts exceeding MATRIX_MAX_ROWS or MATRIX_MAX_COLS, and size
col_gpios with MATRIX_MAX_COLS for consistency.

Fixes: 584bf366f8fa ("Input: matrix_keypad - switch to gpiod API and generic device properties")
Closes: https://sashiko.dev/#/bug/linux-ed4b89af-6c76-4e5f-b140-fb2b107b12d0
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - Drop the redundant zero GPIO count check, as matrix_keypad_build_keymap() already validates positive dimensions, per Dmitry Torokhov's review.
 - Drop the stable tag, per Dmitry Torokhov's review.

 drivers/input/keyboard/matrix_keypad.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 11018382e84e..21c7df4e2e7b 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -33,7 +33,7 @@ struct matrix_keypad {
 	struct gpio_desc *row_gpios[MATRIX_MAX_ROWS];
 	unsigned int num_row_gpios;
 
-	struct gpio_desc *col_gpios[MATRIX_MAX_ROWS];
+	struct gpio_desc *col_gpios[MATRIX_MAX_COLS];
 	unsigned int num_col_gpios;
 
 	unsigned int row_irqs[MATRIX_MAX_ROWS];
@@ -307,6 +307,11 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	if (nrow > MATRIX_MAX_ROWS || ncol > MATRIX_MAX_COLS) {
+		dev_err(&pdev->dev, "too many row or column GPIOs\n");
+		return -EINVAL;
+	}
+
 	keypad->num_row_gpios = nrow;
 	keypad->num_col_gpios = ncol;
 
-- 
2.56.1.839.g22a8290db9-goog

