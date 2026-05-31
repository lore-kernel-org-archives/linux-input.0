Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF725FA05
	for <linux-input@vger.kernel.org>; Sun, 31 May 2026 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780204486; cv=none; b=TOMaIHYVOxoLgTV69I89CGz+bH1JpR0jzH3M38t9BZgeKIo3wpaYbq31x1otR8YJLPoHh27LtcWUlrKCevETcNmtssK0+nZtMUkVfV5am5KS/w1nMp/F/gD3J1rSawWwTcLuc550HjjzJAHZYsyrH0EnpCTZ/T+gUegSavipqXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780204486; c=relaxed/simple;
	bh=QAh0NQqv4JWTJbDRw1X8cJe301Xd6lXcXbV8Eb5Adxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsqifQKbnq9VSWetarWrLjEbbIXRaIq+rZF948lr4bxVCt+1ByHuFY07ehiMDo7ajc95dZtEG+0I7aCGcWmAN+bmtbOLbxuTQlahbq7hM5rKXaeYocXjgpoTYWGUzrYPU6bR5wNvJN3TcpTW89FmSoAD3OPTol/Mbb/ROs2L37M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqeAOO3k; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqeAOO3k"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304d7f31215so2989361eec.1
        for <linux-input@vger.kernel.org>; Sat, 30 May 2026 22:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780204485; x=1780809285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/RQztS3i83KBFs0coHkZpTlYWE+RCzuhvN7oLI1US/Y=;
        b=WqeAOO3kx2HkkBbnd5jVahNo75b1x/a/H9Ud7nwDTMpbO7UJ2tOyDzkXSBdxentqfO
         1wFjUI0FeBG61lBaF1IEf8bnQumtWozLEpD1p8xBAkc1QdAwsz/nxaQzASoQMANPgB/6
         xCoSUEyiRGDZk7JinHtjN1Jq4Rbx9I4e/NNNXOacAOqgDiuBvBRgifDBt0dlr7wv/SlV
         s/WHtS9VbWZX7H29zt1zlfBS6Qj+H/qr4rsBt0b0qT7IQJpy90VNk9BXukOCSC2H7UFY
         nW21dxYcwLI+HBUjRPLzLsvd3QOZmUBEaYiwiEbRM9Uy2SSSgnTdgc8SkJS6A7ZjKSOz
         vMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780204485; x=1780809285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RQztS3i83KBFs0coHkZpTlYWE+RCzuhvN7oLI1US/Y=;
        b=F5KVrYjf7hZf8W52crL8bWAGzeIoP4ITv+bODKlVDrX1Jxj1e9ifHIebAnyO1kQYmg
         m+vSdTGwWrhQwQOPfLP1xKPkM/GyseCzgbPDtuF9jk6StblNW0818o9kuvLzeB+2g9hI
         LLP3l4b/rjXg5yJvITvqQG54Kk55A7BE94SqD3FWzEkQMZVf+mL5CbkyHV0Vif2rOQuV
         3dI2FzvTYOizYphFTwvZjpD0jBr/xNiE5uJwswixVYL7kTZ2HGON2ANjCOPg0cDAt9sS
         xa55vLVj70XieX+p42tsMP7nOIQiyuUe3ZOeX8dtIwAIDzy9SMGgylKZRNa8LSbAbEUF
         iC3A==
X-Forwarded-Encrypted: i=1; AFNElJ+DoDAMvzHbc9SrWhJjYU9N7dD2BgjfQesz4KTDm7Kk3KAljr7o+DZhyj1mnG1d/fa/+J4gFu+KLvAgng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4CXBlx36VXzcivW607OR/CVHm4r77xxmtB6GNIPGvYIQvZ5M
	35/CaoY7se/pUb+LiAW8II5WotCj6orxjEAVDccFEMrNbVtK319iJmTA
X-Gm-Gg: Acq92OGpaMs+4N4DtdNZjCPVcnluEBrrNz3+iQsEbJ7+54nGgA6HLj9ZErWso+FukVH
	M8dEixJXtLQCOLb7Z5zykOXAXihdxdwiiSoyuAwzyCl/UPiJdzQ6zsLgFxxEzovqjZXh85DyVPC
	tn+VgtxXEU7DkZKNW6oHzpQ7P81aM3xBW1RRHJK6hWi7KnCrdrKpe29LXjgHSB6tqSj/HqCP4/i
	qGMxF9KcX/+F22e8v6OAduZV11XBvpQNPbf7FG+4LsDy7GsJb5w+dWYWYxk4uHNqVfP8A8gHkt8
	xn0GSz7KFwMcUZu+jB3zeqAmsB5yN6xcSAIhsNdBYzq/Eka/mAf9ojCeTUojnOrx0F6xTlCdcvl
	xv9ls4eKNe8DVmj42cVCfWhiSsUIjpFvxv4Aw4WWnqz/fqM2uPHCy1zB9LKNCPkwMjr2l5m7xzY
	a4+SmUN5MROCTmcTo8Ij9SqMOcylaiv/C9hMWE99QIaF0LdLaBY5OH3iq4VdyKvXUpr9B7E5NzD
	P62OatHMESB
X-Received: by 2002:a05:7300:f18f:b0:303:f26f:df30 with SMTP id 5a478bee46e88-304fa632e0dmr2503607eec.23.1780204484733;
        Sat, 30 May 2026 22:14:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:aa7b:13a9:ea74:503])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c3121sm5669611eec.5.2026.05.30.22.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 22:14:44 -0700 (PDT)
Date: Sat, 30 May 2026 22:14:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: iqs5xx - Drop unused i2c driver_data
Message-ID: <ahvDvI2GZLpuOE7U@google.com>
References: <20260515165135.498505-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515165135.498505-2-u.kleine-koenig@baylibre.com>

On Fri, May 15, 2026 at 06:51:34PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> The driver doesn't make use of the value that was explicitly assigned to
> the .driver_data members. Drop the assignment. While touching the array,
> convert it to use named initialization which is easier to understand.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Applied, thank you.

-- 
Dmitry
