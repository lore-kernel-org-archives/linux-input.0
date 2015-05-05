From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 0/5] Support for the Sony Motion Controller and other cleanups
Date: Mon,  4 May 2015 22:34:27 -0400
Message-ID: <1430793272-11545-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:44946 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755251AbbEECfG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 4 May 2015 22:35:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, pavel@ucw.cz, Frank Praznik <frank.praznik@oh.rr.com>

This set of patches adds initial support for the Sony Motion Controller via
cleaned-up initial patches from Pavel Machek, streamlines LED initialization
and state updates, adds a comment to explain why the Sixaxis has so many axes
and why they spill over into the multi-touch space and makes some general
cosmetic corrections.

Pavel, could you test the motion controller patches?  I didn't alter the basic
logic from your patch so everything should work, but I'd like to make sure.
