From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/5] Convert x86 platform drivers to use sparse keymap library
Date: Wed, 04 Aug 2010 22:29:52 -0700
Message-ID: <20100805052645.604.28606.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mjg@redhat.com
List-Id: linux-input@vger.kernel.org

The following patch series converts several platform drivers that
employed their private implementation of sparse keymap to use
sparse-keymap library to reduce code duplication.

Please consider applying.

Thanks.

-- 
Dmitry
