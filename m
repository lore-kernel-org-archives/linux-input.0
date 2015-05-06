From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 0/5] Support for the Sony Motion Controller and other cleanups
Date: Tue,  5 May 2015 20:47:27 -0400
Message-ID: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:58501 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755258AbbEFAtm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 May 2015 20:49:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, pavel@ucw.cz, Frank Praznik <frank.praznik@oh.rr.com>

This set of patches adds initial support for the Sony Motion Controller via
cleaned-up initial patches from Pavel Machek, streamlines LED initialization
and state updates, adds a comment to explain why the Sixaxis has so many axes
and why they spill over into the multi-touch space and makes some general
cosmetic corrections.

v2 fixes a bug in the output report initialization failure path, fixes an
omitted pointer assignment and removes the global LED on the motion controller.
