Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07F8288C34;
	Sat, 21 Mar 2026 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774134577; cv=none; b=ujh4AjuRDHbk8OmJyqgOL5Z/9eZq1JDFHbDdeOK8Q9dQGAlTWs4AeXM1b/0+7IK2D9HsGsx0YlEfjm1y1hxT+oJki2n0qCZEqG+i9sZawTApedGaRsQuP612tRWWhwLTnjfyNKigZF41QDzaKImHjNcg1wV/mnHs/4SEeGL89dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774134577; c=relaxed/simple;
	bh=6luGWHB/Ke44MxM9eVxHTaOsaiDXr7u/trsiNaTyY3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXECjJVw+okVzD7XBtL80sEaNqkZHBCMJ9V5KB/cNaC4ZEdq6s7dnla4OkTurVyTtecFBw6Jb2dJOwTTYphmhHNOWW8LtAhRAZT25aX4wBShPc3VyicLWcIpE7L1Oq3vbm2fSEQXL4r8NSLVXUBFq+TVJjTKSnn3pWW0jZZKFds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bKK+AoBc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bKK+AoBc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+zYURl0qg9MLEaBnku9EztntorbAoU4aPnjZ4APx+8g=; b=bKK+AoBcunxa4t6NT+0cPXdjKj
	hJ2TOE0vq135c+aWNaqtHaN/+AZe2UMQiB1Q9RryCMaIWc2HIpVNbRp52nVptwcmonNqRrf3IqKYS
	cAJOaHtCgOksVgCKGGXKiEhwrZ7dkvOnYaoPpRsfiYRSQwlnWFRDHXnD2e+wVWbw5bebr3xX2ID/h
	jv9h//5lV3yxusisJ64/JcBf9pe4yhxqGC/k8cGbz7Otlp5suU0EMtKIun0eMYgidrbfy3YVoniWE
	ERzhpyO36mlIXpWYHGK2nSswP6pY4I/RsIzkfmbvKiXuZqPHFGTwhu61twUhPd+dpW6w9JeFrg12a
	VR1TjyXA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w45Rm-0000000ErYq-3fnz;
	Sat, 21 Mar 2026 23:09:34 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH] Docs: hid: intel-ish-hid: make long URL usable
Date: Sat, 21 Mar 2026 16:09:34 -0700
Message-ID: <20260321230934.435020-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The '\' line continuation character in this long URL
doesn't help anything. There is no documentation tooling that
handles the line continuation character to join the 2 lines
to make a usable URL. Web browsers terminate the URL just
before the '\' character so that the second line of the URL
is lost. See:
  https://docs.kernel.org/hid/intel-ish-hid.html

Join the 2 lines together so that the URL is usable.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

 Documentation/hid/intel-ish-hid.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260320.orig/Documentation/hid/intel-ish-hid.rst
+++ linux-next-20260320/Documentation/hid/intel-ish-hid.rst
@@ -163,8 +163,8 @@ The transport layer is a bi-directional
 - A flow control mechanism to avoid buffer overflows
 
 This protocol resembles bus messages described in the following document:
-http://www.intel.com/content/dam/www/public/us/en/documents/technical-\
-specifications/dcmi-hi-1-0-spec.pdf "Chapter 7: Bus Message Layer"
+http://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/dcmi-hi-1-0-spec.pdf
+"Chapter 7: Bus Message Layer".
 
 Connection and Flow Control Mechanism
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
