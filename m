From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 1/7] Input: ALPS - Move protocol information to Documentation
Date: Sun, 30 Oct 2011 11:33:10 -0400
Message-ID: <4EAD6E36.4070502@canonical.com>
References: <1319663681-11244-1-git-send-email-seth.forshee@canonical.com> <1319663681-11244-2-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58144 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617Ab1J3PdQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Oct 2011 11:33:16 -0400
In-Reply-To: <1319663681-11244-2-git-send-email-seth.forshee@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Rubini <rubini@cvml.unipv.it>, Henrik Rydberg <rydberg@euromail.se>, Andrew Skalski <askalski@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/26/2011 05:14 PM, Seth Forshee wrote:
> In preparation for new protocol support, move the protocol
> information currently documented in alps.c to
> Documentation/input/alps.txt, where it can be expanded without
> cluttering up the driver.
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Makes sense. Only question is whether we should create a subdir for
device protocols (Documentation/input/devices/alps.txt)?

Acked-by: Chase Douglas <chase.douglas@canonical.com>
