From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: 2.6.30-rc1: touchpad disabled on hibernation
Date: Thu, 25 Jun 2009 15:37:27 +0100
Message-ID: <4A438BA7.9010800@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757809AbZFYOhl@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Kernel Testers List <kernel-testers@vger.kernel.org>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-input@vger.kernel.org

The synaptics touchpad on my EeePC 701 dies on hibernation.  2.6.30 was
fine, and it doesn't happen on suspend to ram either.  There are no
obvious error messages, but maybe this boot message is relevant:

Platform driver 'i8042' needs updating, please use dev_pm_ops

Alan
