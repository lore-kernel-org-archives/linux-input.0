From: Benson Leung <bleung@chromium.org>
Subject: [PATCH v3 0/1] Input: add driver for Cypress APA I2C Trackpad
Date: Fri,  7 Dec 2012 15:24:15 -0800
Message-ID: <1354922656-13506-1-git-send-email-bleung@chromium.org>
References: <1354754899-26701-1-git-send-email-bleung@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354754899-26701-1-git-send-email-bleung@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khali@linux-fr.org, dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bleung@chromium.org, djkurtz@chromium.org, olofj@chromium.org, dudl@cypress.com
List-Id: linux-input@vger.kernel.org

Thanks Dmitry, Jean, and Henrik.

Here's V3, which I have confirms compiles on input-next, and works
well on my Chromebook.

v3 : * Handle pointer emulation and unused slots in core
     * Fix compile fail on 3.7 for input_mt_init_slots (Thanks Rydberg)
     * Set BUTTONPAD property only if is a buttonpad based on capabilities.
     * Removed __devinit/__devexit/__devexit_p
     * Set to OFF power mode on cyapa_remove
     * Got rid of kasprintf'd physical location string for static one.
