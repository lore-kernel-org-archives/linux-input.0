Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE26283FE6
	for <linux-input@vger.kernel.org>; Thu, 11 Jun 2026 04:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150811; cv=none; b=YeWHBm274Q8nJMpy9X097AZjos+jc1XyFTNoF4FG3l6uBo7N1YSMAd+JxNLqPbiGC5aGG913S8QJV7iD1g/+uKM5cgQndC5gwXXiVvnxbIoeDjyhUx4JL85b4IJUCkvFixOuG5HwUoD4Naph+ZDDAJTDt0aUpPW3owFr5GkRBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150811; c=relaxed/simple;
	bh=BgS5ORAJRoiuIylmQNMgl7+KoijQ27uQgkWhmji5PCI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jYADn8U/k7rLUD1yqCPX4wtdRR7TFP861OSBUBXo9kCa/dhUsVpBkEmI/jO+vvSOmu2BaMcfmbTpSImna38rRZ8QS1Xaf48OkIatru6opKh+a3mxI8+jHKiuHewkn+9RBWS/N1rLAO0yfGASOE7mxBGSu+6kyeeR6lZZMjfZemE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqrwYWTu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqrwYWTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781150810; x=1812686810;
  h=date:from:to:cc:subject:message-id;
  bh=BgS5ORAJRoiuIylmQNMgl7+KoijQ27uQgkWhmji5PCI=;
  b=nqrwYWTu8EaYSPaoBr2SWrtXpnVPSRx9wQP5RoI7P3nX8tJHOgmvRN3R
   h3RWnj/LehU6WkM85RLZkYUtqpEvNlzEB0cpLmIhng8P5wyqMVEd/9KhU
   HJRY3flip1O3ssGUM5+91K6E22Qc8JV2Smthq0RRh11XrybQk6ayWrdig
   JsR1Ok5Ucn604upBLp+zkTIiiACt6xuCysdi8PVtCUKyq9xORpMCDhZEp
   biKR/fGIOCodb7N8NR7234j76xMd8thwYLeA52W+Egio6Ps14d+wWIx/F
   lvKJ43BZKz6GsM1s3JhvTMxtTTBF39+8Ey1LeVgX+G0r7JrZn+9RlncoG
   g==;
X-CSE-ConnectionGUID: PkULosEjTAGsFvaS7hRu7A==
X-CSE-MsgGUID: gByequRQSyWJp/lDkaNr1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92632871"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="92632871"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 21:06:49 -0700
X-CSE-ConnectionGUID: OMr7ZQqLTqmzh06w4F+9Lw==
X-CSE-MsgGUID: zJwKsWbGRT+pyQAxDVlOjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="276558453"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 10 Jun 2026 21:06:47 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXWgm-000000003vp-2iCy;
	Thu, 11 Jun 2026 04:06:44 +0000
Date: Thu, 11 Jun 2026 06:05:53 +0200
From: kernel test robot <lkp@intel.com>
To: Joshua Leivenzon <hacker1024@users.sourceforge.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Subject: [hid:for-7.2/asus 1/7] drivers/hid/hid-asus.c:1399:14:
 warning: variable 'rsize_orig' is used uninitialized whenever 'if' condition
 is false
Message-ID: <202606110526.QfgiXQTQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.2/asus
head:   9bde6277292c8233fb24fc6e51323027b49d1cde
commit: 92f9f783f013a27a175089950b7b22c3d5a48249 [1/7] HID: asus: Fix up Zenbook Duo report descriptors
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260611/202606110526.QfgiXQTQ-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260611/202606110526.QfgiXQTQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606110526.QfgiXQTQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-asus.c:1399:14: warning: variable 'rsize_orig' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1399 |                 } else if (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) {
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-asus.c:1410:17: note: uninitialized use occurs here
    1410 |                 if (*rsize == rsize_orig &&
         |                               ^~~~~~~~~~
   drivers/hid/hid-asus.c:1399:10: note: remove the 'if' if its condition is always true
    1399 |                 } else if (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) {
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-asus.c:1390:17: note: initialize the variable 'rsize_orig' to silence this warning
    1390 |                 int rsize_orig;
         |                               ^
         |                                = 0
   1 warning generated.


vim +1399 drivers/hid/hid-asus.c

  1370	
  1371	static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
  1372			unsigned int *rsize)
  1373	{
  1374		struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
  1375	
  1376		if (drvdata->quirks & QUIRK_FIX_NOTEBOOK_REPORT &&
  1377				*rsize >= 56 && rdesc[54] == 0x25 && rdesc[55] == 0x65) {
  1378			hid_info(hdev, "Fixing up Asus notebook report descriptor\n");
  1379			rdesc[55] = 0xdd;
  1380		}
  1381		/* For the T100TA/T200TA keyboard dock */
  1382		if (drvdata->quirks & QUIRK_T100_KEYBOARD &&
  1383			 (*rsize == 76 || *rsize == 101) &&
  1384			 rdesc[73] == 0x81 && rdesc[74] == 0x01) {
  1385			hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
  1386			rdesc[74] &= ~HID_MAIN_ITEM_CONSTANT;
  1387		}
  1388		/* For the T100CHI/T90CHI keyboard dock and Zenbook Duo 2024+ keyboards */
  1389		if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI | QUIRK_ZENBOOK_DUO_KEYBOARD)) {
  1390			int rsize_orig;
  1391			int offs;
  1392	
  1393			if (drvdata->quirks & QUIRK_T100CHI) {
  1394				rsize_orig = 403;
  1395				offs = 388;
  1396			} else if (drvdata->quirks & QUIRK_T90CHI) {
  1397				rsize_orig = 306;
  1398				offs = 291;
> 1399			} else if (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) {
  1400				rsize_orig = 257;
  1401				offs = 176;
  1402			}
  1403	
  1404			/*
  1405			 * Change Usage (76h) to Usage Minimum (00h), Usage Maximum
  1406			 * (FFh) and clear the flags in the Input() byte.
  1407			 * Note the descriptor has a bogus 0 byte at the end so we
  1408			 * only need 1 extra byte.
  1409			 */
  1410			if (*rsize == rsize_orig &&
  1411				rdesc[offs] == 0x09 && rdesc[offs + 1] == 0x76) {
  1412				__u8 *new_rdesc;
  1413	
  1414				new_rdesc = devm_kzalloc(&hdev->dev, rsize_orig + 1,
  1415							 GFP_KERNEL);
  1416				if (!new_rdesc)
  1417					return rdesc;
  1418	
  1419				hid_info(hdev, "Fixing up %s keyb report descriptor\n",
  1420					drvdata->quirks & QUIRK_T100CHI ?
  1421					"T100CHI" : drvdata->quirks & QUIRK_T90CHI ?
  1422					"T90CHI" : "ZENBOOK DUO");
  1423	
  1424				memcpy(new_rdesc, rdesc, rsize_orig);
  1425				*rsize = rsize_orig + 1;
  1426				rdesc = new_rdesc;
  1427	
  1428				memmove(rdesc + offs + 4, rdesc + offs + 2, 12);
  1429				rdesc[offs] = 0x19;
  1430				rdesc[offs + 1] = 0x00;
  1431				rdesc[offs + 2] = 0x29;
  1432				rdesc[offs + 3] = 0xff;
  1433				rdesc[offs + 14] = 0x00;
  1434			}
  1435		}
  1436	
  1437		if (drvdata->quirks & QUIRK_G752_KEYBOARD &&
  1438			 *rsize == 75 && rdesc[61] == 0x15 && rdesc[62] == 0x00) {
  1439			/* report is missing usage minimum and maximum */
  1440			__u8 *new_rdesc;
  1441			size_t new_size = *rsize + sizeof(asus_g752_fixed_rdesc);
  1442	
  1443			new_rdesc = devm_kzalloc(&hdev->dev, new_size, GFP_KERNEL);
  1444			if (new_rdesc == NULL)
  1445				return rdesc;
  1446	
  1447			hid_info(hdev, "Fixing up Asus G752 keyb report descriptor\n");
  1448			/* copy the valid part */
  1449			memcpy(new_rdesc, rdesc, 61);
  1450			/* insert missing part */
  1451			memcpy(new_rdesc + 61, asus_g752_fixed_rdesc, sizeof(asus_g752_fixed_rdesc));
  1452			/* copy remaining data */
  1453			memcpy(new_rdesc + 61 + sizeof(asus_g752_fixed_rdesc), rdesc + 61, *rsize - 61);
  1454	
  1455			*rsize = new_size;
  1456			rdesc = new_rdesc;
  1457		}
  1458	
  1459		if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD &&
  1460				*rsize == 331 && rdesc[190] == 0x85 && rdesc[191] == 0x5a &&
  1461				rdesc[204] == 0x95 && rdesc[205] == 0x05) {
  1462			hid_info(hdev, "Fixing up Asus N-KEY keyb report descriptor\n");
  1463			rdesc[205] = 0x01;
  1464		}
  1465	
  1466		/* match many more n-key devices */
  1467		if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD && *rsize > 15) {
  1468			for (int i = 0; i < *rsize - 15; i++) {
  1469				/* offset to the count from 0x5a report part always 14 */
  1470				if (rdesc[i] == 0x85 && rdesc[i + 1] == 0x5a &&
  1471				    rdesc[i + 14] == 0x95 && rdesc[i + 15] == 0x05) {
  1472					hid_info(hdev, "Fixing up Asus N-Key report descriptor\n");
  1473					rdesc[i + 15] = 0x01;
  1474					break;
  1475				}
  1476			}
  1477		}
  1478	
  1479		return rdesc;
  1480	}
  1481	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
