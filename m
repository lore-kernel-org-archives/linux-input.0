From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/2] Make gpio-keys usable as a hat
Date: Tue,  1 Nov 2016 11:25:02 +0100
Message-ID: <20161101102504.3783-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Maarten ter Huurne <maarten@treewalker.org>
List-Id: linux-input@vger.kernel.org

Hi,

With this set of two commits, it is now possible to use the
gpio-keys driver with 4 GPIOs representing a hat (D-pad).
