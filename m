From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] input: Fix autosuspend on bcm5974
Date: Tue, 13 Mar 2012 16:40:33 +0000
Message-ID: <20120313164033.GA16481@srcf.ucam.org>
References: <1331596278-2495-1-git-send-email-mjg@redhat.com>
 <20120313143958.GA2754@polaris.bitmath.org>
 <20120313144941.GA13637@srcf.ucam.org>
 <20120313163218.GA2680@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35548 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab2CMQkg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 12:40:36 -0400
Content-Disposition: inline
In-Reply-To: <20120313163218.GA2680@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Henrik Rydberg <rydberg@bitmath.se>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Ah, I see what you mean now. I'll check whether the hardware reports 
state at resume.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
