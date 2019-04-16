From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: gpio-keys-polled improvements
Date: Tue, 16 Apr 2019 21:57:21 +0200
Message-ID: <1555444645-15156-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello folks,


here're some improvements for the gpio-keys-polled driver.

The first patch isn't in the driver itself, but adds a little module helper
for conditionally declaring oftree module table if oftree is enabled
(only needed for the last patch)


have fun.

--mtx
