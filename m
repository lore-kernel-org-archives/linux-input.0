From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Add KD_X console mode to avoid keyboard passthrough
Date: Tue, 14 Oct 2008 12:25:42 +0100
Message-ID: <20081014112542.GA11613@srcf.ucam.org>
References: <20081012174710.GA5206@srcf.ucam.org> <20081014031244.GE8594@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46877 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255AbYJNLZp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 07:25:45 -0400
Content-Disposition: inline
In-Reply-To: <20081014031244.GE8594@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Yeah, looks like evdev just wasn't switching the console into raw mode - 
the old kbd driver did. Thanks for that, we'll go with that approach.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
