From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 00/14] Input: ALPS - Clean up and rework driver to support newer touchpads
Date: Sun,  3 Feb 2013 15:56:40 -0800
Message-ID: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:46391 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab3BCX5M (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:12 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so2396586dad.27
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:12 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

Several modern ALPS devices require slight variations on existing driver
functions.  This patchset provides a way to "mix and match" various
components, to avoid excessive code duplication and clutter:

 - Separating the report format decoding from processing, so that
   Pinnacle AGx, Rushmore, and Dolphin touchpads can use a common
   processing function.

 - Allowing devices with different register layouts to use the same
   processing functions but disparate init functions.

 - Providing a way to discover touchpads like Pinnacle AGx and Rushmore,
   which are identified by a range of EC report values rather than an
   exact match to a specific E7 report sequence.

 - Storing the bitmap and pixel constants in the alps_data struct, so
   they can be updated if the device uses different values (ala Dolphin).


V1->V2 changes with respect to Rushmore support:

 - Fix MT and trackstick report decoding (credit to Emmanual Thome)


Baseline:

git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next

git pull from:

https://github.com/cernekee/linux alps-v2


Tested on:

Dell E6410 (Pinnacle AGx) - E7/EC: 73 02 64 / 88 07 9d
Dell E6230 (Rushmore without trackstick) - E7/EC: 73 03 0a / 88 08 1d
Dell E6430 (Rushmore with trackstick) - E7/EC: 73 03 0a / 88 08 1d

Dolphin support is new and completely untested; if nobody reports success
we should drop that patch.  Also, there are at least two known Dolphin
versions, which use different init sequences (at least in the Windows
driver).


Commits:

Kevin Cernekee (14):
      Input: ALPS - Document the alps.h data structures
      Input: ALPS - Copy "model" info into alps_data struct
      Input: ALPS - Move alps_get_model() down below hw_init code
      Input: ALPS - Introduce helper function for repeated commands
      Input: ALPS - Rework detection sequence
      Input: ALPS - Use function pointers for different protocol handlers
      Input: ALPS - Move {addr,nibble}_command settings into alps_set_defaults()
      Input: ALPS - Rework detection of Pinnacle AGx touchpads
      Input: ALPS - Fix command mode check
      Input: ALPS - Move pixel and bitmap info into alps_data struct
      Input: ALPS - Make the V3 packet field decoder "pluggable"
      Input: ALPS - Add support for "Rushmore" touchpads
      Input: ALPS - Enable trackstick on Rushmore touchpads
      Input: ALPS - First attempt at "Dolphin" touchpad support

